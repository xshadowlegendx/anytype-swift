import Foundation

final class ObjectTreeWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol {
    
    private let widgetsDI: WidgetsDIProtocol
    private weak var output: ObjectTreeWidgetModuleOutput?
    
    init(widgetsDI: WidgetsDIProtocol, output: ObjectTreeWidgetModuleOutput?) {
        self.widgetsDI = widgetsDI
        self.output = output
    }
    
    // MARK: - HomeWidgetProviderAssemblyProtocol
    
    func make(widgetBlockId: String, widgetObject: HomeWidgetsObjectProtocol) -> HomeWidgetProviderProtocol {
        return ObjectTreeWidgetProvider(
            widgetBlockId: widgetBlockId,
            widgetObject: widgetObject,
            objectTreeWidgetModuleAssembly: widgetsDI.objectTreeWidgetModuleAssembly(),
            output: output
        )
    }
}
