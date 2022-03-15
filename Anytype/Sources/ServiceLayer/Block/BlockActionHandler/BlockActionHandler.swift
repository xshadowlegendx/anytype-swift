import UIKit
import BlocksModels
import Combine
import AnytypeCore
import Amplitude

final class DefaultFileUplodingWorker: MediaFileUploadingWorkerProtocol {
    var contentType: MediaPickerContentType = .images

    private let action: (_ localPath: String) -> Void

    init(action: @escaping (_ localPath: String) -> Void) {
        self.action = action
    }

    func cancel() {
        // do nothing
    }

    func prepare() {
        // do nothing
    }

    func upload(_ localPath: String) {
        action(localPath)
    }

    func finish() {
        // do nothing
    }
}

final class BlockActionHandler: BlockActionHandlerProtocol {
    weak var blockSelectionHandler: BlockSelectionHandler?
    private let document: BaseDocumentProtocol
    
    private let service: BlockActionServiceProtocol
    private let listService: BlockListServiceProtocol
    private let markupChanger: BlockMarkupChangerProtocol
    private let keyboardHandler: KeyboardActionHandlerProtocol
    
    private let fileUploadingDemon = MediaFileUploadingDemon.shared
    private let pastboardHelper = PastboardHelper()
    
    init(
        document: BaseDocumentProtocol,
        markupChanger: BlockMarkupChangerProtocol,
        service: BlockActionServiceProtocol,
        listService: BlockListServiceProtocol,
        keyboardHandler: KeyboardActionHandlerProtocol
    ) {
        self.document = document
        self.markupChanger = markupChanger
        self.service = service
        self.listService = listService
        self.keyboardHandler = keyboardHandler
    }

    // MARK: - Service proxy

    func paste(blockId: BlockId, range: NSRange, completion: @escaping (Bool) -> Void) {
        paste(blockId: blockId, range: range, selectedBlockIds: nil, isPartOfBlock: true, completion: completion)
    }

    func paste(selectedBlockIds: [BlockId], completion: @escaping (Bool) -> Void) {
        paste(blockId: nil, range: nil, selectedBlockIds: selectedBlockIds, isPartOfBlock: false, completion: completion)
    }

    private func paste(blockId: BlockId?, range: NSRange?, selectedBlockIds: [BlockId]?, isPartOfBlock: Bool, completion: @escaping (Bool) -> Void) {
        pastboardHelper.obtainSlots { [weak self] slots in
            // don't handle paste if only text in clipboard and it's valid url
            if slots.onlyTextSlotAvailable,
               let textSlot = slots.textSlot,
               textSlot.isValidURL() {
                return completion(false)
            }
            self?.service.paste(focusedBlockId: blockId,
                                selectedTextRange: range,
                                selectedBlockIds: selectedBlockIds,
                                isPartOfBlock: isPartOfBlock,
                                textSlot: slots.textSlot,
                                htmlSlot: slots.htmlSlot,
                                anySlots: slots.anySlots)

            // paste file slot
            slots.fileSlots?.forEach { itemProvider in

                let operation = MediaFileUploadingOperation(
                    itemProvider: itemProvider,
                    worker: DefaultFileUplodingWorker { localPath in
                        _ = self?.service.pasteFile(focusedBlockId: blockId,
                                                    selectedTextRange: range,
                                                    selectedBlockIds: selectedBlockIds,
                                                    isPartOfBlock: isPartOfBlock,
                                                    localPath: localPath,
                                                    name: itemProvider.suggestedName ?? "")
                    }
                )
                self?.fileUploadingDemon.addOperation(operation)
            }

            completion(true)
        }
    }

    func copy(blocksIds: [BlockId], selectedTextRange: NSRange) {
        let blocksInfo = blocksIds.compactMap {
            document.infoContainer.get(id: $0)
        }
        let anySlots = service.copy(blocksInfo: blocksInfo, selectedTextRange: selectedTextRange)
        pastboardHelper.copy(slots: anySlots)
    }

    func turnIntoPage(blockId: BlockId) -> BlockId? {
        return service.turnIntoPage(blockId: blockId)
    }
    
    func turnInto(_ style: BlockText.Style, blockId: BlockId) {
        service.turnInto(style, blockId: blockId)
    }
    
    func upload(blockId: BlockId, filePath: String) {
        service.upload(blockId: blockId, filePath: filePath)
    }
    
    func setObjectTypeUrl(_ objectTypeUrl: String) {
        service.setObjectTypeUrl(objectTypeUrl)
    }
    
    func setTextColor(_ color: BlockColor, blockId: BlockId) {
        listService.setBlockColor(blockIds: [blockId], color: color.middleware)
    }
    
    func setBackgroundColor(_ color: BlockBackgroundColor, blockId: BlockId) {
        service.setBackgroundColor(blockId: blockId, color: color)
    }
    
    func duplicate(blockId: BlockId) {
        service.duplicate(blockId: blockId)
    }
    
    func setFields(_ fields: [BlockFields], blockId: BlockId) {
        service.setFields(blockFields: fields)
    }
    
    func fetch(url: URL, blockId: BlockId) {
        service.bookmarkFetch(blockId: blockId, url: url.absoluteString)
    }
    
    func checkbox(selected: Bool, blockId: BlockId) {
        service.checked(blockId: blockId, newValue: selected)
    }
    
    func toggle(blockId: BlockId) {
        EventsBunch(contextId: document.objectId, localEvents: [.setToggled(blockId: blockId)])
            .send()
    }
    
    func setAlignment(_ alignment: LayoutAlignment, blockId: BlockId) {
        listService.setAlign(blockIds: [blockId], alignment: alignment)
    }
    
    func delete(blockId: BlockId) {
        service.delete(blockId: blockId)
    }
    
    func moveToPage(blockId: BlockId, pageId: BlockId) {
        listService.moveToPage(blockId: blockId, pageId: pageId)
    }
    
    func createEmptyBlock(parentId: BlockId) {
        service.addChild(info: BlockInformation.emptyText, parentId: parentId)
    }
    
    func addLink(targetId: BlockId, blockId: BlockId) {
        service.add(
            info: .emptyLink(targetId: targetId),
            targetBlockId: blockId,
            position: .bottom
        )
    }
    
    // MARK: - Markup changer proxy
    func toggleWholeBlockMarkup(_ markup: MarkupType, blockId: BlockId) {
        guard let newText = markupChanger.toggleMarkup(markup, blockId: blockId) else { return }
        
        changeTextForced(newText, blockId: blockId)
    }
    
    func changeTextStyle(_ attribute: MarkupType, range: NSRange, blockId: BlockId) {
        guard let newText = markupChanger.toggleMarkup(attribute, blockId: blockId, range: range) else { return }

        Amplitude.instance().logSetMarkup(attribute)

        changeTextForced(newText, blockId: blockId)
    }
    
    func setLink(url: URL?, range: NSRange, blockId: BlockId) {
        let newText: NSAttributedString?
        if let url = url {
            Amplitude.instance().logSetMarkup(MarkupType.link(url))
            newText = markupChanger.setMarkup(.link(url), blockId: blockId, range: range)
        } else {
            newText = markupChanger.removeMarkup(.link(nil), blockId: blockId, range: range)
        }
        
        guard let newText = newText else { return }
        changeTextForced(newText, blockId: blockId)
    }
    
    func setLinkToObject(linkBlockId: BlockId?, range: NSRange, blockId: BlockId) {
        let newText: NSAttributedString?
        if let linkBlockId = linkBlockId {
            Amplitude.instance().logSetMarkup(MarkupType.linkToObject(blockId))
            newText = markupChanger.setMarkup(.linkToObject(linkBlockId), blockId: blockId, range: range)
        } else {
            newText = markupChanger.removeMarkup(.linkToObject(nil), blockId: blockId, range: range)
        }
        
        guard let newText = newText else { return }
        changeTextForced(newText, blockId: blockId)
    }
    
    func handleKeyboardAction(
        _ action: CustomTextView.KeyboardAction,
        info: BlockInformation
    ) {
        keyboardHandler.handle(info: info, action: action)
    }
    
    func changeTextForced(_ text: NSAttributedString, blockId: BlockId) {
        guard let info = document.infoContainer.get(id: blockId) else { return }

        guard case .text = info.content else { return }

        let middlewareString = AttributedTextConverter.asMiddleware(attributedText: text)

        EventsBunch(
            contextId: document.objectId,
            localEvents: [.setText(blockId: info.id, text: middlewareString)]
        ).send()

        service.setTextForced(contextId: document.objectId, blockId: info.id, middlewareString: middlewareString)
    }
    
    func changeText(_ text: NSAttributedString, info: BlockInformation) {
        guard case .text = info.content else { return }

        let middlewareString = AttributedTextConverter.asMiddleware(attributedText: text)

        EventsBunch(
            contextId: document.objectId,
            dataSourceUpdateEvents: [.setText(blockId: info.id, text: middlewareString)]
        ).send()

        service.setText(contextId: document.objectId, blockId: info.id, middlewareString: middlewareString)
    }
    
    // MARK: - Public methods
    func uploadMediaFile(itemProvider: NSItemProvider, type: MediaPickerContentType, blockId: BlockId) {
        EventsBunch(
            contextId: document.objectId,
            localEvents: [.setLoadingState(blockId: blockId)]
        ).send()
        
        let operation = MediaFileUploadingOperation(
            itemProvider: itemProvider,
            worker: BlockMediaUploadingWorker(
                objectId: document.objectId,
                blockId: blockId,
                contentType: type
            )
        )
        fileUploadingDemon.addOperation(operation)

        Amplitude.instance().logUploadMedia(type: type.asFileBlockContentType)
    }
    
    func uploadFileAt(localPath: String, blockId: BlockId) {
        Amplitude.instance().logUploadMedia(type: .file)

        EventsBunch(
            contextId: document.objectId,
            localEvents: [.setLoadingState(blockId: blockId)]
        ).send()
        
        upload(blockId: blockId, filePath: localPath)
    }
    
    func createPage(targetId: BlockId, type: ObjectTemplateType) -> BlockId? {
        guard let info = document.infoContainer.get(id: targetId) else { return nil }
        var position: BlockPosition
        if case .text(let blockText) = info.content, blockText.text.isEmpty {
            position = .replace
        } else {
            position = .bottom
        }
        
        return service.createPage(targetId: targetId, type: type, position: position)
    }

    func addBlock(_ type: BlockContentType, blockId: BlockId) {
        guard type != .smartblock(.page) else {
            anytypeAssertionFailure("Use createPage func instead", domain: .blockActionsService)
            _ = service.createPage(targetId: blockId, type: .bundled(.page), position: .bottom)
            return
        }
            
        guard let newBlock = BlockBuilder.createNewBlock(type: type) else { return }
        guard let info = document.infoContainer.get(id: blockId) else { return }
        
        let position: BlockPosition = info.isTextAndEmpty ? .replace : .bottom
        
        service.add(info: newBlock, targetBlockId: info.id, position: position)
    }

    func selectBlock(info: BlockInformation) {
        blockSelectionHandler?.didSelectEditingState(info: info)
    }

    func createAndFetchBookmark(
        targetID: BlockId,
        position: BlockPosition,
        url: String
    ) {
        service.createAndFetchBookmark(
            contextID: document.objectId,
            targetID: targetID,
            position: position,
            url: url
        )
    }
}
