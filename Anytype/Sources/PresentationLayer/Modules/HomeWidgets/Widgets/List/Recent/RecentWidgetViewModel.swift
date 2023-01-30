import Foundation
import BlocksModels
import Combine

@MainActor
final class RecentWidgetViewModel: ListWidgetViewModelProtocol, WidgetContainerContentViewModelProtocol, ObservableObject {
    
    private enum Constants {
        static let maxItems = 3
    }
    
    // MARK: - DI
    
    private let widgetBlockId: BlockId
    private let widgetObject: HomeWidgetsObjectProtocol
    private let recentSubscriptionService: RecentSubscriptionServiceProtocol
    private weak var output: CommonWidgetModuleOutput?
    
    // MARK: - State
    
    private var rowDetails: [ObjectDetails] = []
    
    // MARK: - WidgetContainerContentViewModelProtocol
    
    let name: String = Loc.recent
    let menuItems: [WidgetMenuItem] = []
    
    // MARK: - ListWidgetViewModelProtocol
    
    @Published private(set) var rows: [ListWidgetRow.Model] = []
    let minimimRowsCount = Constants.maxItems
    
    init(
        widgetBlockId: BlockId,
        widgetObject: HomeWidgetsObjectProtocol,
        recentSubscriptionService: RecentSubscriptionServiceProtocol,
        output: CommonWidgetModuleOutput?
    ) {
        self.widgetBlockId = widgetBlockId
        self.widgetObject = widgetObject
        self.recentSubscriptionService = recentSubscriptionService
        self.output = output
    }
    
    // MARK: - ListWidgetViewModelProtocol
    
    func onAppear() {
        setupAllSubscriptions()
    }

    func onDisappear() {
        recentSubscriptionService.stopSubscription()
    }
    
    func onHeaderTap() {
        // TODO: Open screen
    }
    
    // MARK: - Private
    
    private func setupAllSubscriptions() {
        recentSubscriptionService.startSubscription(
            objectLimit: Constants.maxItems,
            update: { [weak self] _, update in
                self?.rowDetails.applySubscriptionUpdate(update)
                self?.updateViewState()
            }
        )
    }
    
    private func updateViewState() {
        rows = rowDetails.map { details in
            ListWidgetRow.Model(
                details: details,
                onTap: { [weak self] in
                    self?.output?.onObjectSelected(screenData: $0)
                }
            )
        }
    }
}
