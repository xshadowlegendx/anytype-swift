import Foundation
import UIKit
import SwiftUI


enum EditorModuleContainerViewBuilder {
    typealias ChildViewModel = EditorModuleContentViewModel
    typealias ChildViewController = EditorModuleContentViewController
    typealias ChildViewBuilder = EditorModuleContentViewBuilder
    
    typealias SelfComponent = (viewController: EditorModuleContainerViewController, viewModel: EditorModuleContainerViewModel, childComponent: EditorModuleContentModule)
    
    static func view(id: String) -> EditorModuleContainerViewController {
        self.selfComponent(id: id).0
    }
    
    static func childComponent(id: String) -> EditorModuleContentModule {
        ChildViewBuilder.сontent(id: id)
    }
    
    private static func selfComponent(id: String) -> SelfComponent {
        let childComponent = self.childComponent(id: id)
        
        let childViewController = childComponent.0
        
        let navigationController = createNavigationController(child: childViewController)
        
        /// Configure Navigation Item for Content View Model.
        /// We need it to support Selection navigation bar buttons.
        let childViewModel = childComponent.1
        childViewModel.configured(navigationItem: childViewController.navigationItem)
        
        /// Don't forget configure router by events from blocks.
        let router: DocumentViewRouting.CompoundRouter = .init()
        _ = router.configured(userActionsStream: childComponent.2)
        
        /// Configure ViewModel of current View Controller.
        let viewModel = EditorModuleContainerViewModel()
        _ = viewModel.configured(router: router)
        
        /// Configure current ViewController.
        let viewController = EditorModuleContainerViewController(viewModel: viewModel, childViewController: navigationController)
        childViewController.navigationItem.leftBarButtonItem = createBackButton(container: viewController)

        /// DEBUG: Conformance to navigation delegate.
        navigationController.delegate = viewController
        
        return (viewController, viewModel, childComponent)
    }
    
    private static func createBackButton(container: EditorModuleContainerViewController) -> UIBarButtonItem {
        let backButtonImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        return UIBarButtonItem(image: backButtonImage, style: .plain, target: container, action: #selector(container.dismissAction))
    }
    
    private static func createNavigationController(child: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(
            navigationBarClass: EditorModuleContainerViewBuilder.NavigationBar.self,
            toolbarClass: nil
        )
        NavigationBar.applyAppearance()
        navigationController.setViewControllers([child], animated: false)
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
}

// MARK: Custom Appearance
/// TODO: Move it somewhere
private extension EditorModuleContainerViewBuilder {
    class NavigationBar: UINavigationBar {
        static func applyAppearance() {
            let appearance = Self.appearance()
            appearance.prefersLargeTitles = false
            appearance.tintColor = .gray
            appearance.backgroundColor = .white
        }
    }
}
