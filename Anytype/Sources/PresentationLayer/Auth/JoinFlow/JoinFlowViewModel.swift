import SwiftUI

@MainActor
final class JoinFlowViewModel: ObservableObject, JoinFlowStepOutput {
    
    @Published var step: JoinFlowStep = JoinFlowStep.firstStep
    @Published var forward = true
    @Published var errorText: String? {
        didSet {
            showError = errorText.isNotNil
        }
    }
    @Published var showError: Bool = false
    @Published var disableBackAction: Bool = false
    
    var counter: String {
        "\(step.rawValue) / \(JoinFlowStep.totalCount)"
    }
    
    // MARK: - State
    private let state = JoinFlowState()
    
    private weak var output: JoinFlowOutput?
    private let applicationStateService: ApplicationStateServiceProtocol
    private let accountManager: AccountManagerProtocol
    
    init(
        output: JoinFlowOutput?,
        applicationStateService: ApplicationStateServiceProtocol,
        accountManager: AccountManagerProtocol
    ) {
        self.output = output
        self.applicationStateService = applicationStateService
        self.accountManager = accountManager
    }
    
    func content() -> AnyView? {
        output?.onStepChanged(step, state: state, output: self)
    }
    
    // MARK: - JoinStepOutput
    
    func onNext() {
        guard let nextStep = step.next else {
            finishFlow()
            return
        }
        forward = true
        
        withAnimation {
            step = nextStep
        }
    }
    
    func onBack() {
        guard let previousStep = step.previous else { return }
        forward = false
        
        withAnimation {
            step = previousStep
        }
    }
    
    func onError(_ error: Error) {
        errorText = error.localizedDescription
    }
    
    func disableBackAction(_ disable: Bool) {
        disableBackAction = disable
    }
    
    func keyPhraseMoreInfo() -> AnyView? {
        output?.keyPhraseMoreInfo()
    }
    
    private func finishFlow() {
        applicationStateService.state = .home
        AnytypeAnalytics.instance().logAccountOpen(
            analyticsId: accountManager.account.info.analyticsId
        )
        if state.soul.isEmpty {
            AnytypeAnalytics.instance().logOnboardingSkipName()
        }
    }
}
