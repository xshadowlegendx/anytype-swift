import Foundation
import SwiftUI
import Services

protocol HomeBottomNavigationPanelModuleAssemblyProtocol {
    @MainActor
    func make(homePath: HomePath, output: HomeBottomNavigationPanelModuleOutput?) -> AnyView
}

final class HomeBottomNavigationPanelModuleAssembly: HomeBottomNavigationPanelModuleAssemblyProtocol {
    
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    // MARK: - HomeBottomNavigationPanelModuleAssemblyProtocol
    
    @MainActor
    func make(homePath: HomePath, output: HomeBottomNavigationPanelModuleOutput?) -> AnyView {
        return HomeBottomNavigationPanelView(
            homePath: homePath,
            model: HomeBottomNavigationPanelViewModel(
                activeWorkpaceStorage: self.serviceLocator.activeWorkspaceStorage(),
                subscriptionService: self.serviceLocator.singleObjectSubscriptionService(),
                defaultObjectService: self.serviceLocator.defaultObjectCreationService(),
                processSubscriptionService: self.serviceLocator.processSubscriptionService(),
                output: output
            )
        ).eraseToAnyView()
    }
}
