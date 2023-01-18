import Foundation

protocol WidgetsDIProtocol {
    func homeWidgetsRegistry(treeWidgetOutput: ObjectTreeWidgetModuleOutput?) -> HomeWidgetsRegistryProtocol
    func objectTreeWidgetModuleAssembly() -> ObjectTreeWidgetModuleAssemblyProtocol
    func bottomPanelProviderAssembly() -> HomeBottomPanelProviderAssemblyProtocol
    func bottomPanelModuleAssembly() -> HomeBottomPanelModuleAssemblyProtocol
}

final class WidgetsDI: WidgetsDIProtocol {
    
    private let serviceLocator: ServiceLocator
    private let uiHelpersDI: UIHelpersDIProtocol
    
    init(serviceLocator: ServiceLocator, uiHelpersDI: UIHelpersDIProtocol) {
        self.serviceLocator = serviceLocator
        self.uiHelpersDI = uiHelpersDI
    }
    
    // MARK: - WidgetsDIProtocol
    
    func homeWidgetsRegistry(treeWidgetOutput: ObjectTreeWidgetModuleOutput?) -> HomeWidgetsRegistryProtocol {
        return HomeWidgetsRegistry(
            treeWidgetProviderAssembly: ObjectTreeWidgetProviderAssembly(widgetsDI: self, output: treeWidgetOutput),
            objectDetailsStorage: serviceLocator.objectDetailsStorage()
        )
    }
    
    func objectTreeWidgetModuleAssembly() -> ObjectTreeWidgetModuleAssemblyProtocol {
        return ObjectTreeWidgetModuleAssembly(serviceLocator: serviceLocator, uiHelpersDI: uiHelpersDI)
    }
    
    func bottomPanelProviderAssembly() -> HomeBottomPanelProviderAssemblyProtocol {
        return HomeBottomPanelProviderAssembly(widgetsDI: self)
    }
    
    func bottomPanelModuleAssembly() -> HomeBottomPanelModuleAssemblyProtocol {
        return HomeBottomPanelModuleAssembly(serviceLocator: serviceLocator, uiHelpersDI: uiHelpersDI)
    }
}
