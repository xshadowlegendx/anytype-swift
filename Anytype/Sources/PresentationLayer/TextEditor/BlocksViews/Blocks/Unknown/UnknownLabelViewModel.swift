import BlocksModels
import UIKit

struct UnknownLabelViewModel: BlockViewModelProtocol {
    let indentationLevel = 0
    let information: BlockInformation
    
    var hashable: AnyHashable {
        [
            indentationLevel,
            information
        ] as [AnyHashable]
    }
    
    init(information: BlockInformation) {
        self.information = information
    }
    
    func makeContextualMenu() -> [ContextualMenu] {
        []
    }
    
    func handle(action: ContextualMenu) {
        assertionFailure("Handling of contextual menu items not supported")
    }
    
    func makeContentConfiguration() -> UIContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = "\(information.content.identifier) -> \(information.id)"
        return contentConfiguration
    }
    
    func didSelectRowInTableView() { }
}
