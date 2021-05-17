import Foundation
import SwiftUI
import Combine
import os
import BlocksModels


extension DocumentEditorViewModel {
    enum State {
        case loading
        case empty
        case ready
    }
    var state: State {
        switch self.internalState {
        case .loading: return .loading
        default: return self.builders.isEmpty ? .empty : .ready
        }
    }
}
 
class DocumentEditorViewModel: ObservableObject {
    typealias BlocksUserAction = BlocksViews.UserAction

    /// View Input
    weak var viewInput: EditorModuleDocumentViewInput?

    /// Service
    private var blockActionsService: BlockActionsServiceSingle = .init()
    private lazy var blockActionHandler = BlockActionHandler(documentId: self.documentViewModel.documentId, documentViewInteraction: self)

    /// Document ViewModel
    private(set) var documentViewModel: DocumentViewModelProtocol = DocumentViewModel()

    /// DocumentDetailsViewModel
    let detailsViewModel: DocumentDetailsViewModel = DocumentDetailsViewModel()
    
    /// User Interaction Processor
    private lazy var oldblockActionHandler: BlockActionsHandlersFacade = .init(documentViewInteraction: self)
    private var listBlockActionHandler: ListBlockActionHandler = .init()

    /// Combine Subscriptions
    private var subscriptions: Set<AnyCancellable> = .init()

    /// Selection Handler
    private(set) var selectionHandler: EditorModuleSelectionHandlerProtocol?

    private var listToolbarSubject: PassthroughSubject<BlocksViews.Toolbar.UnderlyingAction, Never> = .init()

    private var publicUserActionSubject: PassthroughSubject<BlocksUserAction, Never> = .init()
    lazy var publicUserActionPublisher: AnyPublisher<BlocksUserAction, Never> = { self.publicUserActionSubject.eraseToAnyPublisher() }()

    private var publicActionsPayloadSubject: PassthroughSubject<BaseBlockViewModel.ActionsPayload, Never> = .init()
    lazy var publicActionsPayloadPublisher: AnyPublisher<BaseBlockViewModel.ActionsPayload, Never> = { self.publicActionsPayloadSubject.eraseToAnyPublisher() }()

    private var publicSizeDidChangeSubject: PassthroughSubject<Void, Never> = .init()
    lazy private(set) var publicSizeDidChangePublisher: AnyPublisher<Void, Never> = { self.publicSizeDidChangeSubject.eraseToAnyPublisher() }()

    private var listActionsPayloadSubject: PassthroughSubject<ActionsPayload, Never> = .init()
    lazy private var listActionsPayloadPublisher: AnyPublisher<ActionsPayload, Never> = {
        self.listActionsPayloadSubject.eraseToAnyPublisher()
    }()

    @Published var error: String?

    // MARK: Page View Models

    /// Builders to build block views
    @Published private(set) var builders: [BaseBlockViewModel] = [] {
        didSet {
            if self.builders.isEmpty {
                self.set(selectionEnabled: false)
            }
        }
    }
    private var internalState: State = .loading

    /// We should update some items in place.
    /// For that, we use this subject which send events that some items are just updated, not removed or deleted.
    /// Its `Output` is a `List<BlockId>`
    private let updateElementsSubject: PassthroughSubject<Set<BlockId>, Never> = .init()
    private(set) var updateElementsPublisher: AnyPublisher<Set<BlockId>, Never> = .empty()
    private var lastSetTextClosure: (() -> Void)?

    // MARK: - Initialization

    init(documentId: String) {
        self.setupSubscriptions()

        // TODO: Deprecated.
        // We should rename it.
        // Our case would be the following
        // We should expose one publisher that will publish different updates (delete/update/add) to outer world.
        // Or to our view controller.
        // Maybe it will publish only resulted collection of elements.
        self.updateElementsPublisher = self.updateElementsSubject.eraseToAnyPublisher()

        self.obtainDocument(documentId: documentId)
    }

    /// Apply last setText action, to ensure text was saved after document was closed
    func applyPendingChanges() {
        self.lastSetTextClosure?()
    }

    // MARK: - Setup subscriptions

    private func setupSubscriptions() {
        self.publicActionsPayloadPublisher.sink { [weak self] (value) in
            self?.process(actionsPayload: value)
        }.store(in: &self.subscriptions)

        _ = self.oldblockActionHandler.configured(self.publicActionsPayloadPublisher)

        self.listToolbarSubject.sink { [weak self] (value) in
            self?.process(toolbarAction: value)
        }.store(in: &self.subscriptions)

        _ = self.listBlockActionHandler.configured(self.listActionsPayloadPublisher)

        self.oldblockActionHandler.reactionPublisher.sink { [weak self] (value) in
            self?.process(reaction: value)
        }.store(in: &self.subscriptions)

        self.listBlockActionHandler.reactionPublisher.sink { [weak self] (value) in
            self?.process(reaction: value)
        }.store(in: &self.subscriptions)

        self.$builders.sink { [weak self] value in
            self?.enhanceUserActionsAndPayloads(value)
        }.store(in: &self.subscriptions)
    }

    // TODO: Add caching?
    private func update(builders: [BaseBlockViewModel]) {
        let difference = builders.difference(from: self.builders) {$0.diffable == $1.diffable}
        if !difference.isEmpty, let result = self.builders.applying(difference) {
            self.builders = result
            self.viewInput?.updateData(self.builders)
        }
    }

    private func obtainDocument(documentId: String?) {
        guard let documentId = documentId else { return }
        self.internalState = .loading

        self.blockActionsService.open(contextID: documentId, blockID: documentId)
            .reciveOnMain()
            .sink(receiveCompletion: { [weak self] (value) in
                switch value {
                case .finished: break
                case let .failure(error):
                    self?.internalState = .empty
                    self?.error = error.localizedDescription
                }
            }, receiveValue: { [weak self] value in
                self?.handleOpenDocument(value)
            }).store(in: &self.subscriptions)
    }

    private func remove(buildersWith ids: Set<BlockId>) {
        var indexSet: IndexSet = .init()
        var itemsToDelete: [BaseBlockViewModel] = []

        let startIndex = self.builders.startIndex
        let endIndex = self.builders.endIndex

        var buildersIndex = startIndex

        while buildersIndex != endIndex, ids.count != itemsToDelete.count {
            let item = self.builders[buildersIndex]
            if ids.contains(item.blockId) {
                indexSet.insert(buildersIndex)
                itemsToDelete.append(item)
            }
            buildersIndex = buildersIndex.advanced(by: 1)
        }
        self.builders.remove(atOffsets: indexSet)
        self.viewInput?.delete(rows: itemsToDelete)
    }

    private func insert(builders: [BaseBlockViewModel], after blockId: BlockId) {
        guard let index = self.builders.firstIndex(where: { $0.blockId == blockId }) else { return }
        let builder = self.builders[index]
        self.builders.insert(contentsOf: builders, at: index + 1)
        self.viewInput?.insert(rows: builders, after: builder)
    }


    private func handleOpenDocument(_ value: ServiceSuccess) {
        // sink publisher
        self.documentViewModel.updatePublisher()
            .reciveOnMain()
            .sink { [weak self] (value) in
                switch value.updates {
                case .general:
                    self?.update(builders: value.models)
                case let .update(update):
                    if let toggledId = update.openedToggleId {
                        self?.insert(builders: value.models, after: toggledId)
                    }
                    if !update.addedIds.isEmpty {
                        self?.update(builders: value.models)
                    }
                    if !update.updatedIds.isEmpty && update.addedIds.isEmpty && update.deletedIds.isEmpty {
                        // During split or merge neighborhood blocks will update automaticaly because of
                        // calculating diff in data source
                        self?.updateDiffableValuesForBlockIds(update.updatedIds)
                        self?.updateElementsSubject.send(update.updatedIds)
                    }
                    if !update.deletedIds.isEmpty {
                        self?.remove(buildersWith: update.deletedIds)
                        let ids = update.deletedIds.reduce(into: [BlockId: BlockContentType]()) { result, blockId in
                            guard let container = self?.documentViewModel.rootActiveModel?.container else { return }
                            result[blockId] = container.get(by: blockId)?.information.content.type
                        }
                        self?.deselect(ids: ids)
                    }
                }
            }.store(in: &self.subscriptions)
            
        self.documentViewModel.open(value)
        
        documentViewModel.pageDetailsPublisher()
            .reciveOnMain()
            .sink { [weak self] detailsInformationProvider in
                let iconEmoji: String? = {
                    guard
                        let emoji = detailsInformationProvider.iconEmoji?.value,
                        emoji.isSingleEmoji
                    else {
                        return nil
                    }
                    
                    return emoji
                }()
                
                self?.detailsViewModel.iconEmoji = iconEmoji
            }
            .store(in: &subscriptions)

        self.configureInteractions(self.documentViewModel.documentId)
    }
    
    private func updateDiffableValuesForBlockIds(_ ids: Set<BlockId>) {
        // In case we update just several blocks (for example turn into Paragraph -> Header)
        // we also need to update diffable value for such blocks
        // to reduce updates when we will calculate differencies using diff algorithm
        let updatedViewModels = builders.filter { ids.contains($0.blockId) }
        updatedViewModels.forEach { $0.updateDiffable() }
    }

    private func configureInteractions(_ documentId: BlockId?) {
        guard let documentId = documentId else {
            assertionFailure("configureInteractions(_:). DocumentId is not configured.")
            return
        }
        _ = self.oldblockActionHandler.configured(documentId: documentId).configured(self)
        _ = self.listBlockActionHandler.configured(documentId: documentId)
    }
    
}

// MARK: - DocumentViewInteraction

extension DocumentEditorViewModel: DocumentViewInteraction {
    func updateBlocks(with ids: Set<BlockId>) {
        self.updateElementsSubject.send(ids)
    }
}

// MARK: - Reactions

private extension DocumentEditorViewModel {
    func process(reaction: BlockActionService.Reaction) {
        switch reaction {
        case let .shouldHandleEvent(value):
            let events = value.events
            let actionType = value.actionType

            self.documentViewModel.handle(events: events)

            switch actionType {
            case .deleteBlock, .merge:
                let firstResponderBlockId = self.documentViewModel.userSession?.firstResponderId()
                
                if let firstResponderIndex = self.builders.firstIndex(where: { $0.blockId == firstResponderBlockId }) {
                    self.viewInput?.setFocus(at: firstResponderIndex)
                }
            default: break
            }
        default: return
        }
    }

    func process(reaction: ListBlockActionHandler.Reaction) {
        switch reaction {
        case let .shouldHandleEvent(value):
            let events = value.payload.events
            self.documentViewModel.handle(events: events)
        }
    }
}

// MARK: - On Tap Gesture

extension DocumentEditorViewModel {
    func handlingTapIfEmpty() {
        self.oldblockActionHandler.createEmptyBlock(
            listIsEmpty: self.state == .empty, parentModel: self.documentViewModel.rootActiveModel
        )
    }
}

// MARK: - Selection Handling

extension DocumentEditorViewModel {
    func didSelectBlock(at index: IndexPath) {
        if self.selectionEnabled() {
            self.didSelect(atIndex: index)
            return
        }
        self.element(at: index)?.receive(event: .didSelectRowInTableView)
    }

    private func element(at: IndexPath) -> BaseBlockViewModel? {
        guard self.builders.indices.contains(at.row) else {
            assertionFailure("Row doesn't exist")
            return nil
        }
        return self.builders[at.row]
    }

    private func didSelect(atIndex: IndexPath) {
        guard let item = element(at: atIndex) else { return }
        self.set(selected: !self.selected(id: item.blockId),
                 id: item.blockId,
                 type: item.getBlock().blockModel.information.content.type)
    }
}

// MARK: - Process actions

private extension DocumentEditorViewModel {
    func process(actionsPayload: BaseBlockViewModel.ActionsPayload) {
        switch actionsPayload {
        case let .textView(value):
            switch value.action {
            case .textView(.showMultiActionMenuAction(.showMultiActionMenu)):
                self.set(selectionEnabled: true)
            default: return
            }
        // TODO: we need coordinator(router) here that show this view https://app.clickup.com/t/h13ytp
        case let .showCodeLanguageView(languages, completion):
            self.viewInput?.showCodeLanguageView(with: languages, completion: completion)
        case let .showStyleMenu(blockModel):
            self.viewInput?.showStyleMenu(blockModel: blockModel)
        case let .becomeFirstResponder(blockModel):
            self.documentViewModel.userSession?.setFirstResponder(with: blockModel)
        case .toolbar, .marksPane, .userAction: return
        }
    }

    func process(_ value: EditorSelectionToolbarPresenter.SelectionAction) {
        switch value {
        case let .selection(value):
            switch value {
            case let .selectAll(value):
                switch value {
                case .selectAll: self.selectAll()
                case .deselectAll: self.deselectAll()
                }
            case .done(.done): self.set(selectionEnabled: false)
            }
        case let .toolbar(value):
            let selectedIds = self.list()
            switch value {
            case let .turnInto(payload): self.publicUserActionSubject.send(.toolbars(.turnIntoBlock(.init(output: self.listToolbarSubject, input: payload))))
            case .delete: self.listActionsPayloadSubject.send(.toolbar(.init(model: selectedIds, action: .editBlock(.delete))))
            case .copy: break
            }
        }
    }

    func process(toolbarAction: BlocksViews.Toolbar.UnderlyingAction) {
        let selectedIds = self.list()
        self.listActionsPayloadSubject.send(.toolbar(.init(model: selectedIds, action: toolbarAction)))
    }
}

extension DocumentEditorViewModel {
    enum ActionsPayload {
        typealias ListModel = [BlockId]

        struct Toolbar {
            typealias Model = ListModel
            typealias Action = BlocksViews.Toolbar.UnderlyingAction
            var model: Model
            var action: Action
        }
        
        case toolbar(Toolbar)
    }
}

extension DocumentEditorViewModel {
    func configured(multiSelectionUserActionPublisher: AnyPublisher<EditorSelectionToolbarPresenter.SelectionAction, Never>) -> Self {
        multiSelectionUserActionPublisher.sink { [weak self] (value) in
            self?.process(value)
        }.store(in: &self.subscriptions)
        return self
    }

    func configured(selectionHandler: EditorModuleSelectionHandlerProtocol?) -> Self {
        self.selectionHandler = selectionHandler
        return self
    }
}

// MARK: - Debug

extension DocumentEditorViewModel: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(String(reflecting: Self.self)) -> \(String(describing: self.documentViewModel.documentId))"
    }
}

// MARK: - Enhance UserActions and Payloads

/// These methods work in opposite way as `Merging`.
/// Instead, we just set a "delegate" ( no, our Subject ) to all viewModels in a List.
/// So, we have different approach.
///
/// 1. We have one Subject that we give to all ViewModels.
///
extension DocumentEditorViewModel {
    func enhanceUserActionsAndPayloads(_ builders: [BlockViewBuilderProtocol]) {
        let ourViewModels = builders.compactMap({$0 as? BaseBlockViewModel})
        ourViewModels.forEach { (value) in
            _ = value.configured(userActionSubject: self.publicUserActionSubject)
            _ = value.configured(actionsPayloadSubject: self.publicActionsPayloadSubject)
            _ = value.configured(sizeDidChangeSubject: self.publicSizeDidChangeSubject)
        }
    }
    
}

// MARK: - Public methods for view controller

extension DocumentEditorViewModel {

    /// Block action handler
    func handleAction(_ action: BlockActionHandler.ActionType) {
        guard let firstResponder = documentViewModel.userSession?.firstResponder() else { return }
        
        blockActionHandler?.handleBlockAction(action, block: firstResponder) { [weak self] actionType, events in
            self?.process(reaction: .shouldHandleEvent(.init(actionType: actionType, events: events)))
        }
    }
}

extension DocumentEditorViewModel: EditorModuleSelectionHandlerHolderProtocol {
    func selectAll() {
        let ids = self.builders.dropFirst().reduce(into: [BlockId: BlockContentType]()) { result, model in
            result[model.blockId] = model.getBlock().blockModel.information.content.type
        }
        self.select(ids: ids)
    }
}
