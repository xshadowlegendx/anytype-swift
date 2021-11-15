import Combine
import BlocksModels
import UIKit

struct TextBlockContentConfiguration: BlockConfigurationProtocol {
    
    let blockDelegate: BlockDelegate
    
    let block: BlockModelProtocol
    let information: BlockInformation
    let content: BlockText
    let text: UIKitAnytypeText
    
    let upperBlock: BlockModelProtocol?
    
    let shouldDisplayPlaceholder: Bool
    let isCheckable: Bool
    
    let focusPublisher: AnyPublisher<BlockFocusPosition, Never>
    let actionHandler: BlockActionHandlerProtocol
    let detailsStorage: ObjectDetailsStorageProtocol
    let showPage: (String) -> Void
    let openURL: (URL) -> Void
        
    let pressingEnterTimeChecker = TimeChecker()
    var currentConfigurationState: UICellConfigurationState?
    
    init(
        blockDelegate: BlockDelegate,
        block: BlockModelProtocol,
        content: BlockText,
        upperBlock: BlockModelProtocol?,
        isCheckable: Bool,
        actionHandler: BlockActionHandlerProtocol,
        showPage: @escaping (String) -> Void,
        openURL: @escaping (URL) -> Void,
        focusPublisher: AnyPublisher<BlockFocusPosition, Never>,
        detailsStorage: ObjectDetailsStorageProtocol
    ) {
        self.blockDelegate = blockDelegate
        self.block = block
        self.content = content
        self.upperBlock = upperBlock
        self.actionHandler = actionHandler
        self.showPage = showPage
        self.openURL = openURL
        self.focusPublisher = focusPublisher
        self.information = block.information
        self.isCheckable = isCheckable
        self.detailsStorage = detailsStorage
        
        self.text = content.anytypeText(using: detailsStorage)
        shouldDisplayPlaceholder = block.isToggled && block.information.childrenIds.isEmpty
    }
    
    func makeContentView() -> UIView & UIContentView {
        TextBlockContentView(configuration: self)
    }
}

extension TextBlockContentConfiguration: Hashable {
    
    static func == (lhs: TextBlockContentConfiguration, rhs: TextBlockContentConfiguration) -> Bool {
        lhs.information == rhs.information &&
        lhs.currentConfigurationState == rhs.currentConfigurationState &&
        lhs.shouldDisplayPlaceholder == rhs.shouldDisplayPlaceholder &&
        lhs.isCheckable == rhs.isCheckable
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(information.id)
        hasher.combine(information.alignment)
        hasher.combine(information.backgroundColor)
        hasher.combine(information.content)
        hasher.combine(shouldDisplayPlaceholder)
        hasher.combine(isCheckable)
        hasher.combine(currentConfigurationState)
    }
}
