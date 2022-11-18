import Foundation
import UIKit
import SwiftUI

protocol ObjectCoverPickerModuleAssemblyProtocol {
    func make(document: BaseDocumentProtocol) -> UIViewController
}

final class ObjectCoverPickerModuleAssembly: ObjectCoverPickerModuleAssemblyProtocol {
    
    // MARK: - ObjectCoverPickerModuleAssemblyProtocol
    
    func make(document: BaseDocumentProtocol) -> UIViewController {
        let viewModel = ObjectCoverPickerViewModel(
            document: document,
            fileService: ServiceLocator.shared.fileService(),
            detailsService: ServiceLocator.shared.detailsService(objectId: document.objectId)
        )
        
        let controller = UIHostingController(
            rootView: ObjectCoverPicker(viewModel: viewModel)
        )
        
        controller.rootView.onDismiss = { [weak controller] in
            controller?.dismiss(animated: true)
        }
        
        return controller
    }
}
