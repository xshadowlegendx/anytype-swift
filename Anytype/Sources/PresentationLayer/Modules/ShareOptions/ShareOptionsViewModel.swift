import Foundation
import SharedContentManager
import Services
import AnytypeCore

@MainActor
final class ShareOptionsViewModel: ObservableObject {
    
    private let contentManager: SharedContentManagerProtocol
    private let interactor: ShareOptionsInteractorProtocol
    private let activeWorkpaceStorage: ActiveWorkpaceStorageProtocol
    private weak var output: ShareOptionsModuleOutput?
    
    // First Group
    @Published var newObjectTitle: String = ""
    @Published var embededObjectTitle: String = ""
    @Published var saveAsType: ShareSaveAsType = .newObject
    // Second Group
    @Published var spaceName: String = ""
    @Published var linkTitle: String = ""
    @Published var linkObjectName: String = ""
    // Navigation
    @Published var isSaveButtonAvailable = false
    @Published var dismiss = false
    @Published var saveInProgress = false
    
    private var saveOptions: SharedSaveOptions?
    private var counter = ShareContentCounter(textCount: 0, bookmarksCount: 0, filesCount: 0)
    private var spaceDetails: SpaceView?
    private var linkObjectDetails: ObjectDetails?
    
    init(
        contentManager: SharedContentManagerProtocol,
        interactor: ShareOptionsInteractorProtocol,
        activeWorkpaceStorage: ActiveWorkpaceStorageProtocol,
        output: ShareOptionsModuleOutput?
    ) {
        self.contentManager = contentManager
        self.interactor = interactor
        self.activeWorkpaceStorage = activeWorkpaceStorage
        self.output = output
        setupData()
    }
    
    func onTapSaveAsNewObject() {
        saveAsType = .newObject
        updateDataState()
    }
    
    func onTapSaveAsBlock() {
        saveAsType = .block
        updateDataState()
    }
    
    func onTapCancel() {
        try? contentManager.clearSharedContent()
        dismiss.toggle()
    }
    
    func onTapSave() {
        guard let saveOptions else {
            anytypeAssertionFailure("Try to save sharing content without save options", info: [
                "saveAsType": "\(saveAsType)",
                "spaceDetailsIsNit": spaceDetails.isNil.description,
                "linkObjectDetailsIsNil": linkObjectDetails.isNil.description,
                "counter": "\(counter)"
            ])
            return
        }
        
        Task {
            saveInProgress = true
            let content = try contentManager.getSharedContent()
            try await interactor.saveContent(saveOptions: saveOptions, content: content)
            try contentManager.clearSharedContent()
            dismiss.toggle()
        }
    }
    
    func onTapSelectSpace() {
        output?.onSpaceSelection { [weak self] newSpaceView in
            self?.spaceDetails = newSpaceView
            self?.updateDataState()
        }
    }
    
    func onTapLinkObject() {
        guard let spaceDetails else {
            anytypeAssertionFailure("Try open document selection without space")
            return
        }
        output?.onDocumentSelection(
            data: SearchModuleModel(
                spaceId: spaceDetails.targetSpaceId,
                title: linkTitle,
                layoutLimits: saveAsType.supportedLayouts,
                onSelect: { [weak self] searchData in
                    self?.linkObjectDetails = searchData.details
                    self?.updateDataState()
                }
            )
        )
    }
    // MARK: - Private
    
    private func setupData() {
        guard let content = try? contentManager.getSharedContent() else {
            try? contentManager.clearSharedContent()
            return
        }
        
        counter.textCount = content.filter(\.isText).count
        counter.bookmarksCount = content.filter(\.isUrl).count
        counter.filesCount = content.filter(\.isFile).count
        spaceDetails = activeWorkpaceStorage.spaceView()
        
        updateDataState()
    }
    
    private func updateDataState() {
        validateLinkToObject()
        updateSaveButton()
        updateTitles()
    }
    
    private func updateTitles() {
        if counter.onlyText {
            newObjectTitle = Loc.Sharing.Text.noteObject
            embededObjectTitle = Loc.Sharing.Text.textBlock
        } else if counter.onlyBookmarks {
            newObjectTitle = Loc.Sharing.Url.bookmark
            embededObjectTitle = Loc.Sharing.Url.text
        } else if counter.onlyFiles {
            newObjectTitle = Loc.Sharing.File.newObject
            embededObjectTitle = Loc.Sharing.File.block
        } else {
            newObjectTitle = Loc.Sharing.Any.newObject
            embededObjectTitle = Loc.Sharing.Any.block
        }
        
        switch saveAsType {
        case .newObject:
            linkTitle = Loc.Sharing.linkTo
        case .block:
            linkTitle = Loc.Sharing.addTo
        }
        
        spaceName = spaceDetails?.name ?? ""
        linkObjectName = linkObjectDetails?.title ?? ""
    }
    
    private func updateSaveButton() {
        updateSpaceOptions()
        isSaveButtonAvailable = saveOptions.isNotNil
    }
    
    private func updateSpaceOptions() {
        guard let spaceDetails else {
            saveOptions = nil
            return
        }
        
        switch saveAsType {
        case .newObject:
            saveOptions = .newObject(spaceId: spaceDetails.targetSpaceId, linkToObject: linkObjectDetails)
        case .block:
            if let linkObjectDetails {
                saveOptions = .blocks(spaceId: spaceDetails.targetSpaceId, addToObject: linkObjectDetails)
            } else {
                saveOptions = nil
            }
        }
    }
    
    private func validateLinkToObject() {
        guard let linkObjectDetails else { return }
        
        if !saveAsType.supportedLayouts.contains(linkObjectDetails.layoutValue) {
            self.linkObjectDetails = nil
        }
        
        if linkObjectDetails.spaceId != spaceDetails?.targetSpaceId {
            self.linkObjectDetails = nil
        }
    }
}
