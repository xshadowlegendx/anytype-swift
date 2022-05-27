import SwiftUI
import Combine
import LocalAuthentication

class LoginViewModel: ObservableObject {
    private let authService = ServiceLocator.shared.authService()
    private lazy var cameraPermissionVerifier = CameraPermissionVerifier()
    private let seedService: SeedServiceProtocol

    @Published var seed: String = ""
    @Published var showQrCodeView: Bool = false
    @Published var openSettingsURL = false
    @Published var error: String? {
        didSet {
            showError = false
            
            if error.isNotNil {
                showError = true
            }
        }
    }
    @Published var showError: Bool = false
    
    @Published var entropy: String = "" {
        didSet {
            onEntropySet()
        }
    }
    @Published var showSelectProfile = false
    let canRestoreFromKeychain: Bool

    private var subscriptions = [AnyCancellable]()

    init(seedService: SeedServiceProtocol = ServiceLocator.shared.seedService()) {
        self.canRestoreFromKeychain = (try? seedService.obtainSeed()).isNotNil
        self.seedService = seedService
    }
    
    func onEntropySet() {
        let result = authService.mnemonicByEntropy(entropy)
        switch result {
        case .failure(let error):
            self.error = error.localizedDescription
        case .success(let seed):
            self.seed = seed
            recoverWallet()
        }
    }
    
    func recoverWallet() {
        recoverWallet(with: seed)
    }

    func onShowQRCodeTap() {
        cameraPermissionVerifier.cameraPermission
            .receiveOnMain()
            .sink { [unowned self] isGranted in
                if isGranted {
                    showQrCodeView = true
                } else {
                    openSettingsURL = true
                }
            }
            .store(in: &subscriptions)
    }

    func restoreFromkeychain() {
        LocalAuth.auth(reason: "Restore secret phrase from keychain".localized) { [unowned self] didComplete in
            guard didComplete,
                  let phrase = try? seedService.obtainSeed() else {
                return
            }

            recoverWallet(with: phrase)            
        }
    }

    private func recoverWallet(with string: String) {
        let result = authService.walletRecovery(mnemonic: string.trimmingCharacters(in: .whitespacesAndNewlines))
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .failure(let error):
                self?.error = error.localizedDescription
            case .success:
                try? self?.seedService.saveSeed(string)
                self?.showSelectProfile = true
            }
        }
    }
}
