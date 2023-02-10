import Foundation
import BlocksModels

protocol HomeWidgetsRegistryProtocol {
    func providers(blocks: [BlockInformation], widgetObject: HomeWidgetsObjectProtocol) -> [HomeSubmoduleProviderProtocol]
}

final class HomeWidgetsRegistry: HomeWidgetsRegistryProtocol {

    private struct ProviderCache {
        let widgetBlockId: String
        let widgetObjectId: String
        let provider: HomeSubmoduleProviderProtocol
        let source: HomeWidgetProviderAssemblyProtocol
    }
    
    private enum Constants {
        static let favoriteWidgetId = "FavoriteWidgetId"
        static let recentWidgetId = "RecentWidgetId"
        static let setsWidgetId = "SetsWidgetId"
        static let binWidgetId = "BinWidgetId"
    }
    
    private let treeWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let setWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let favoriteWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let recentWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let setsWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let linkWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let binLinkWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol
    private let stateManager: HomeWidgetsStateManagerProtocol
    private let objectDetailsStorage: ObjectDetailsStorage
    private var providersCache: [ProviderCache] = []
    
    init(
        treeWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        setWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        favoriteWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        recentWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        setsWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        linkWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        binLinkWidgetProviderAssembly: HomeWidgetProviderAssemblyProtocol,
        stateManager: HomeWidgetsStateManagerProtocol,
        objectDetailsStorage: ObjectDetailsStorage
    ) {
        self.treeWidgetProviderAssembly = treeWidgetProviderAssembly
        self.setWidgetProviderAssembly = setWidgetProviderAssembly
        self.favoriteWidgetProviderAssembly = favoriteWidgetProviderAssembly
        self.recentWidgetProviderAssembly = recentWidgetProviderAssembly
        self.setsWidgetProviderAssembly = setsWidgetProviderAssembly
        self.linkWidgetProviderAssembly = linkWidgetProviderAssembly
        self.binLinkWidgetProviderAssembly = binLinkWidgetProviderAssembly
        self.stateManager = stateManager
        self.objectDetailsStorage = objectDetailsStorage
    }
    
    // MARK: - HomeWidgetsRegistryProtocol
    
    func providers(
        blocks: [BlockInformation],
        widgetObject: HomeWidgetsObjectProtocol
    ) -> [HomeSubmoduleProviderProtocol] {
        
        var newProvidersCache: [ProviderCache] = blocks.compactMap { block in
            guard case let .widget(widget) = block.content else { return nil }
            
            guard let contentId = widgetObject.targetObjectIdByLinkFor(widgetBlockId: block.id),
                  let contentDetails = objectDetailsStorage.get(id: contentId) else { return nil }
            
            switch widget.layout {
            case .link:
                return createProviderCache(
                    source: linkWidgetProviderAssembly,
                    widgetBlockId: block.id,
                    widgetObject: widgetObject
                )
            case .tree:
                guard contentDetails.editorViewType == .page else { return nil }
                return createProviderCache(
                    source: treeWidgetProviderAssembly,
                    widgetBlockId: block.id,
                    widgetObject: widgetObject
                )
            case .list:
                guard contentDetails.editorViewType == .set() else { return nil }
                return createProviderCache(
                    source: setWidgetProviderAssembly,
                    widgetBlockId: block.id,
                    widgetObject: widgetObject
                )
            }
        }
        
        // TODO: Add local state provider for widgets: favorite, set, recent, bin.
        // Or implement it in middleware.
        
        newProvidersCache.append(
            createProviderCache(
                source: favoriteWidgetProviderAssembly,
                widgetBlockId: Constants.favoriteWidgetId,
                widgetObject: widgetObject
            )
        )
        
        newProvidersCache.append(
            createProviderCache(
                source: recentWidgetProviderAssembly,
                widgetBlockId: Constants.recentWidgetId,
                widgetObject: widgetObject
            )
        )
        
        newProvidersCache.append(
            createProviderCache(
                source: setsWidgetProviderAssembly,
                widgetBlockId: Constants.setsWidgetId,
                widgetObject: widgetObject
            )
        )
        
        newProvidersCache.append(
            createProviderCache(
                source: binLinkWidgetProviderAssembly,
                widgetBlockId: Constants.binWidgetId,
                widgetObject: widgetObject
            )
        )
        
        providersCache = newProvidersCache
        return providersCache.map { $0.provider }
    }
    
    // MARK: - Private
    
    private func createProviderCache(
        source: HomeWidgetProviderAssemblyProtocol,
        widgetBlockId: String,
        widgetObject: HomeWidgetsObjectProtocol
    ) -> ProviderCache {
        let cache = providersCache.first {
            $0.source === source
            && $0.widgetBlockId == widgetBlockId
            && $0.widgetObjectId == widgetObject.objectId
        }
        
        if let cache {
            return cache
        }
        
        let provider = source.make(widgetBlockId: widgetBlockId, widgetObject: widgetObject, stateManager: stateManager)
        
        let newCache = ProviderCache(
            widgetBlockId: widgetBlockId,
            widgetObjectId: widgetObject.objectId,
            provider: provider,
            source: source
        )
        
        return newCache
    }
}
