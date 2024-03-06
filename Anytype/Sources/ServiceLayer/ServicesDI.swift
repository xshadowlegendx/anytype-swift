import Foundation
import SecureService
@_exported import Factory

extension Container {
    
    var activeWorkpaceStorage: Factory<ActiveWorkpaceStorageProtocol> {
        self { ActiveWorkspaceStorage() }.singleton
    }
    
    var accountManager: Factory<AccountManagerProtocol> {
        self { AccountManager() }.singleton
    }
    
    var accountEventHandler: Factory<AccountEventHandlerProtocol> {
        self { AccountEventHandler() }.singleton
    }
    
    var workspaceStorage: Factory<WorkspacesStorageProtocol> {
        self { ServiceLocator.shared.workspaceStorage() }
    }
    
    var singleObjectSubscriptionService: Factory<SingleObjectSubscriptionServiceProtocol> {
        self { ServiceLocator.shared.singleObjectSubscriptionService() }
    }
    
    var subscriptionToggler: Factory<SubscriptionTogglerProtocol> {
        self { SubscriptionToggler() }.shared
    }
    
    var pasteboardHelper: Factory<PasteboardHelperProtocol> {
        self { PasteboardHelper() }
    }
    
    var pasteboardBlockService: Factory<PasteboardBlockServiceProtocol> {
        self { PasteboardBlockService() }
    }
    
    var localRepoService: Factory<LocalRepoServiceProtocol> {
        self { LocalRepoService() }.shared
    }
    
    var keychainStore: Factory<KeychainStoreProtocol> {
        self { KeychainStore() }.shared
    }
    
    var seedService: Factory<SeedServiceProtocol> {
        self { SeedService() }.shared
    }
    
    var usecaseService: Factory<UsecaseServiceProtocol> {
        self { UsecaseService() }.shared
    }
    
    var fileActionsService: Factory<FileActionsServiceProtocol> {
        self { FileActionsService() }.shared
    }
    
    var searchService: Factory<SearchServiceProtocol> {
        self { SearchService() }.shared
    }
    
    var subscriptionStorageProvider: Factory<SubscriptionStorageProviderProtocol> {
        self { SubscriptionStorageProvider() }.singleton
    }
    
    var systemURLService: Factory<SystemURLServiceProtocol> {
        self { SystemURLService() }.shared
    }
    
    var groupsSubscriptionsHandler: Factory<GroupsSubscriptionsHandlerProtocol> {
        self { GroupsSubscriptionsHandler() }
    }
    
    var objectTypeProvider: Factory<ObjectTypeProviderProtocol> {
        self { ObjectTypeProvider.shared }
    }
}
