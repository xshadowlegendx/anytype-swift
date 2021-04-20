import UIKit
import SwiftUI
import Combine

protocol MainWindowHolder {
    func startNewRootView<ViewType: View>(_ view: ViewType)
}

class ApplicationCoordinator: MainWindowHolder {
    private let window: MainWindow
    
    private let pageScrollViewLayout = GlobalEnvironment.OurEnvironmentObjects.PageScrollViewLayout()
    private let shakeHandler: ShakeHandler
    
    private let localRepoService: LocalRepoServiceProtocol
    private let authService: AuthServiceProtocol
    private let appearanceService: AppearanceService
    private let firebaseService: FirebaseService
    
    private let authAssembly: AuthAssembly
    
    init(
        window: MainWindow,
        shakeHandler: ShakeHandler,
        localRepoService: LocalRepoServiceProtocol,
        authService: AuthServiceProtocol,
        appearanceService: AppearanceService,
        firebaseService: FirebaseService,
        authAssembly: AuthAssembly
    ) {
        self.window = window
        self.shakeHandler = shakeHandler
        
        self.localRepoService = localRepoService
        self.authService = authService
        self.appearanceService = appearanceService
        self.firebaseService = firebaseService
        
        self.authAssembly = authAssembly
    }

    func start() {
        runAtFirstLaunch()
        runServicesOnStartup()
        login()
    }
    
    private func runAtFirstLaunch() {
        if UserDefaultsConfig.installedAtDate == nil {
            UserDefaultsConfig.installedAtDate = Date()
        }
    }
    
    private func runServicesOnStartup() {
        shakeHandler.run()
        appearanceService.resetToDefaults()
        firebaseService.setup()
    }

    // MARK: Login
    private func login() {
        let userId = UserDefaultsConfig.usersIdKey // TODO: Remove static
        guard userId.isEmpty == false else {
            showAuthScreen()
            return
        }
        
        self.authService.selectAccount(id: userId, path: localRepoService.middlewareRepoPath) { [weak self] result in
            switch result {
            case .success:
                self?.showHomeScreen()
            case .failure:
                self?.showAuthScreen()
            }
        }
    }
    
    private func showHomeScreen() {
        let homeAssembly = OldHomeViewAssembly()
        let view = homeAssembly.createOldHomeView()
        self.startNewRootView(view)
    }
    
    private func showAuthScreen() {
        startNewRootView(authAssembly.authView())
    }
    
    private func startNewRootViewController(_ controller: UIViewController) {
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    // MARK: - MainWindowHolder
    func startNewRootView<ViewType: View>(_ view: ViewType) {
        window.rootViewController = UIHostingController(rootView: view.environmentObject(self.pageScrollViewLayout))
        window.makeKeyAndVisible()
    }
}
