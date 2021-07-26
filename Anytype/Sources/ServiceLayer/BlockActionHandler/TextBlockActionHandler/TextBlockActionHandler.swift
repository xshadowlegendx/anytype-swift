import BlocksModels
import os
import Combine


final class TextBlockActionHandler {
    private let service: BlockActionServiceProtocol
    private var textService: BlockActionsServiceText = .init()
    private let contextId: String
    private let modelsHolder: SharedBlockViewModelsHolder

    init(
        contextId: String,
        service: BlockActionServiceProtocol,
        modelsHolder: SharedBlockViewModelsHolder
    ) {
        self.service = service
        self.contextId = contextId
        self.modelsHolder = modelsHolder
    }

    func handlingTextViewAction(_ block: BlockModelProtocol, _ action: CustomTextView.UserAction) {
        switch action {
        case let .keyboardAction(value):
            handlingKeyboardAction(block, value)
        case let .changeTextForStruct(attributedText):
            fallthrough
        case let .changeText(attributedText):
            handleChangeText(block, text: attributedText)
        case .changeTextStyle:
            assertionFailure("We handle this update in `BlockActionHandler`")
        case .showMultiActionMenuAction, .showStyleMenu, .changeCaretPosition:
            break
        case let .shouldChangeText(range, replacementText, mentionsHolder):
            mentionsHolder.removeMentionIfNeeded(
                replacementRange: range,
                replacementText: replacementText
            )
        }
    }
    
    private func handleChangeText(_ block: BlockModelProtocol, text: NSAttributedString) {
        guard case var .text(textContentType) = block.information.content else { return }
        var blockModel = block

        let blockId = blockModel.information.id
        textContentType.attributedText = text
        blockModel.information.content = .text(textContentType)

        textService.setText(contextID: contextId, blockID: blockId, attributedString: text)
    }

    private func handlingKeyboardAction(_ block: BlockModelProtocol, _ action: CustomTextView.UserAction.KeyboardAction) {
        if DetailsKind(rawValue: block.information.id) == .name {
            switch action {
            case .enterAtTheEndOfContent, .enterInsideContent, .enterOnEmptyContent:
                let id = block.information.id
                let (blockId, _) = DetailsAsBlockConverter.IdentifierBuilder.asDetails(id)
                let block = block.container?.model(id: blockId)
                let parentId = block?.information.id
                let information = BlockBuilder.createDefaultInformation()

                if let parentId = parentId {
                    if block?.information.childrenIds.isEmpty == true {
                        self.service.addChild(info: information, parentBlockId: parentId)
                    }
                    else {
                        let first = block?.information.childrenIds.first
                        service.add(info: information, targetBlockId: first ?? "", position: .top, shouldSetFocusOnUpdate: true)
                    }
                }

            default: return
            }
            return
        }
        
        switch action {
        // .enterWithPayload and .enterAtBeginning should be used with BlockSplit
        case let .enterInsideContent(left, payload):
            if let newBlock = BlockBuilder.createInformation(block: block, action: action, textPayload: payload ?? "") {
                if let oldText = left {
                    guard case let .text(text) = block.information.content else {
                        assertionFailure("Only text block may send keyboard action")
                        return
                    }
                    self.service.split(
                        info: block.information,
                        oldText: oldText,
                        newBlockContentType: text.contentType.contentTypeForSplit,
                        shouldSetFocusOnUpdate: true
                    )
                }
                else {
                    self.service.add(
                        info: newBlock, targetBlockId: block.information.id, position: .bottom, shouldSetFocusOnUpdate: true
                    )
                }
            }

        case let .enterOnEmptyContent(payload): // we should assure ourselves about type of block.
            /// TODO: Fix it in TextView API.
            /// If payload is empty, so, handle it as .enter ( or .enter at the end )
            if payload?.isEmpty == true {
                self.handlingKeyboardAction(block, .enterAtTheEndOfContent)
                return
            }
            if let newBlock = BlockBuilder.createInformation(block: block, action: action, textPayload: payload ?? "") {
                if !payload.isNil, case let .text(text) = block.information.content {
                    self.service.split(
                        info: block.information,
                        oldText: "",
                        newBlockContentType: text.contentType.contentTypeForSplit,
                        shouldSetFocusOnUpdate: true
                    )
                }
                else {
                    self.service.add(info: newBlock, targetBlockId: block.information.id, position: .bottom, shouldSetFocusOnUpdate: true)
                }
            }

        case .enterAtTheEndOfContent:
            // BUSINESS LOGIC:
            // We should check that if we are in `list` block and its text is `empty`, we should turn it into `.text`
            switch block.information.content {
            case let .text(value) where value.contentType.isList && value.attributedText.string == "":
                // Turn Into empty text block.
                if let newContentType = BlockBuilder.createContentType(block: block, action: action, textPayload: value.attributedText.string) {
                    /// TODO: Add focus on this block.
                    self.service.turnInto(
                        blockId: block.information.id,
                        type: newContentType,
                        shouldSetFocusOnUpdate: true
                    )
                }
            default:
                if let newBlock = BlockBuilder.createInformation(block: block, action: action, textPayload: "") {
                    /// TODO:
                    /// Uncomment when you are ready.
                    //                        self.service.add(newBlock: newBlock, afterBlockId: block.blockId, shouldSetFocusOnUpdate: true)
                    // "We should not use self.service.split here. Instead, we should self.service.add block. It is possible to swap them only after set focus total cleanup. Redo it."

                    switch block.information.content {
                    case let .text(payload):
                        let isListAndNotToggle = payload.contentType.isListAndNotToggle
                        let isToggleAndOpen = payload.contentType == .toggle && block.isToggled
                        // In case of return was tapped in list block (for toggle it should be open)
                        // and this block has children, we will insert new child block at the beginning
                        // of children list, otherwise we will create new block under current block
                        let childrenIds = block.information.childrenIds
                        switch (childrenIds.isEmpty, isToggleAndOpen, isListAndNotToggle) {
                        case (true, true, _):
                            self.service.addChild(info: newBlock, parentBlockId: block.information.id)
                        case (false, true, _), (false, _, true):
                            let firstChildId = childrenIds[0]
                            self.service.add(
                                info: newBlock,
                                targetBlockId: firstChildId,
                                position: .top,
                                shouldSetFocusOnUpdate: true
                            )
                        default:
                            let newContentType = payload.contentType.isList ? payload.contentType : .text
                            let oldText = payload.attributedText.clearedFromMentionAtachmentsString()
                            self.service.split(
                                info: block.information,
                                oldText: oldText,
                                newBlockContentType: newContentType,
                                shouldSetFocusOnUpdate: true
                            )
                        }
                    default: return
                    }

                }
            }

        case .deleteWithPayload(_):
            guard let previousModel = modelsHolder.findModel(beforeBlockId: block.information.id) else {
                assertionFailure("""
                    We can't find previous block to focus on at command .deleteWithPayload
                    Block: \(block.information.id)
                    Moving to .delete command.
                    """
                )
                self.handlingKeyboardAction(block, .deleteOnEmptyContent)
                return
            }
            let previousBlockId = previousModel.blockId
            
            var localEvents = [LocalEvent]()
            if case let .text(text) = previousModel.information.content {
                let range = NSRange(location: text.attributedText.length, length: 0)
                localEvents.append(contentsOf: [
                    .setTextMerge(blockId: previousBlockId),
                    .setFocus(blockId: previousBlockId, position: .at(range))
                ])
            }

            service.merge(firstBlockId: previousModel.blockId, secondBlockId: block.information.id, localEvents: localEvents)
            break

        case .deleteOnEmptyContent:
            service.delete(blockId: block.information.id) { [weak self] value in
                guard let previousModel = self?.modelsHolder.findModel(beforeBlockId: block.information.id) else {
                    assertionFailure(
                        "We can't find previous block to focus on at command .delete for block \(block.information.id)"
                    )
                    return .init(middlewareEvents: value.messages, localEvents: [])
                }
                let previousBlockId = previousModel.blockId
                return .init(
                    middlewareEvents: value.messages,
                    localEvents: [
                        .setFocus(blockId: previousBlockId, position: .end)
                    ]
                )
            }
        }
    }
}

extension BlockText.Style {
    // We do want to create regular text block when splitting title block
    var contentTypeForSplit: BlockText.Style {
        self == .title ? .text : self
    }
}
