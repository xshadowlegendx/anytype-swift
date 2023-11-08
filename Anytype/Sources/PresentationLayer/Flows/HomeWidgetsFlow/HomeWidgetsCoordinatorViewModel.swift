import Foundation
import SwiftUI
import Combine
import Services
import AnytypeCore
import NavigationBackport

@MainActor
final class HomeWidgetsCoordinatorViewModel: ObservableObject,
                                             HomeWidgetsModuleOutput, CommonWidgetModuleOutput,
                                             HomeBottomPanelModuleOutput, HomeBottomNavigationPanelModuleOutput {
    
    // MARK: - DI
    
    private let homeWidgetsModuleAssembly: HomeWidgetsModuleAssemblyProtocol
    private let activeWorkspaceStorage: ActiveWorkpaceStorageProtocol
    private let navigationContext: NavigationContextProtocol
    private let createWidgetCoordinatorAssembly: CreateWidgetCoordinatorAssemblyProtocol
    private let searchModuleAssembly: SearchModuleAssemblyProtocol
    private let newSearchModuleAssembly: NewSearchModuleAssemblyProtocol
    private let dashboardService: DashboardServiceProtocol
    private let appActionsStorage: AppActionStorage
    private let widgetTypeModuleAssembly: WidgetTypeModuleAssemblyProtocol
    private let spaceSwitchCoordinatorAssembly: SpaceSwitchCoordinatorAssemblyProtocol
    private let spaceSettingsCoordinatorAssembly: SpaceSettingsCoordinatorAssemblyProtocol
    private let shareCoordinatorAssembly: ShareCoordinatorAssemblyProtocol
    private let editorCoordinatorAssembly: EditorCoordinatorAssemblyProtocol
    private let homeBottomNavigationPanelModuleAssembly: HomeBottomNavigationPanelModuleAssemblyProtocol
    private let objectTypeSearchModuleAssembly: ObjectTypeSearchModuleAssemblyProtocol

    // MARK: - State
    
    private var viewLoaded = false
    private var subscriptions = [AnyCancellable]()
    
    @Published var showChangeSourceData: WidgetChangeSourceSearchModuleModel?
    @Published var showChangeTypeData: WidgetTypeModuleChangeModel?
    @Published var showSearchData: SearchModuleModel?
    @Published var showSpaceSwitch: Bool = false
    @Published var showCreateWidgetData: CreateWidgetCoordinatorModel?
    @Published var showSpaceSettings: Bool = false
    @Published var showSharing: Bool = false
    @Published var editorPath = HomePath()
    @Published var showCreateObjectWithType: Bool = false

    @Published var info: AccountInfo? {
        didSet {
            // Prevent animation for first sync
            if oldValue.isNotNil {
                homeAnimationId = UUID()
            }
        }
    }
    @Published var homeAnimationId = UUID()
    
    var pageNavigation: PageNavigation {
        PageNavigation(
            push: { [weak self] data in
                self?.editorPath.push(data)
            }, pop: { [weak self] in
                self?.editorPath.pop()
            }, replace: { [weak self] data in
                self?.editorPath.replaceLast(data)
            }
        )
    }

    init(
        homeWidgetsModuleAssembly: HomeWidgetsModuleAssemblyProtocol,
        activeWorkspaceStorage: ActiveWorkpaceStorageProtocol,
        navigationContext: NavigationContextProtocol,
        createWidgetCoordinatorAssembly: CreateWidgetCoordinatorAssemblyProtocol,
        searchModuleAssembly: SearchModuleAssemblyProtocol,
        newSearchModuleAssembly: NewSearchModuleAssemblyProtocol,
        dashboardService: DashboardServiceProtocol,
        appActionsStorage: AppActionStorage,
        widgetTypeModuleAssembly: WidgetTypeModuleAssemblyProtocol,
        spaceSwitchCoordinatorAssembly: SpaceSwitchCoordinatorAssemblyProtocol,
        spaceSettingsCoordinatorAssembly: SpaceSettingsCoordinatorAssemblyProtocol,
        shareCoordinatorAssembly: ShareCoordinatorAssemblyProtocol,
        editorCoordinatorAssembly: EditorCoordinatorAssemblyProtocol,
        homeBottomNavigationPanelModuleAssembly: HomeBottomNavigationPanelModuleAssemblyProtocol,
        objectTypeSearchModuleAssembly: ObjectTypeSearchModuleAssemblyProtocol
    ) {
        self.homeWidgetsModuleAssembly = homeWidgetsModuleAssembly
        self.activeWorkspaceStorage = activeWorkspaceStorage
        self.navigationContext = navigationContext
        self.createWidgetCoordinatorAssembly = createWidgetCoordinatorAssembly
        self.searchModuleAssembly = searchModuleAssembly
        self.newSearchModuleAssembly = newSearchModuleAssembly
        self.dashboardService = dashboardService
        self.appActionsStorage = appActionsStorage
        self.widgetTypeModuleAssembly = widgetTypeModuleAssembly
        self.spaceSwitchCoordinatorAssembly = spaceSwitchCoordinatorAssembly
        self.spaceSettingsCoordinatorAssembly = spaceSettingsCoordinatorAssembly
        self.shareCoordinatorAssembly = shareCoordinatorAssembly
        self.editorCoordinatorAssembly = editorCoordinatorAssembly
        self.homeBottomNavigationPanelModuleAssembly = homeBottomNavigationPanelModuleAssembly
        self.objectTypeSearchModuleAssembly = objectTypeSearchModuleAssembly
    }

    func onAppear() {
        guard !viewLoaded else { return }
        viewLoaded = true
        
        activeWorkspaceStorage
            .workspaceInfoPublisher
            .receiveOnMain()
            .sink { [weak self] info in
                if self?.info != nil, self?.info != info {
                    self?.editorBrowserCoordinator.dismissAllPages()
                }
                self?.info = info
            }
            .store(in: &subscriptions)
        
        appActionsStorage.$action
            .compactMap { $0 }
            .receiveOnMain()
            .sink { [weak self] action in
                self?.handleAppAction(action: action)
                self?.appActionsStorage.action = nil
            }
            .store(in: &subscriptions)
        
        // Disable push
        // Transaction with disablesAnimations doesnt work
        // From ios 16, delete restoreLastOpenPage and use init for restore state. Read restoreLastOpenPage comment.
        // setAnimationsEnabled will be not needed
        UINavigationBar.setAnimationsEnabled(false)
        editorPath.restoreLastOpenPage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
    
    func homeWidgetsModule() -> AnyView? {
        guard let info else { return nil }
        return homeWidgetsModuleAssembly.make(info: info, output: self, widgetOutput: self, bottomPanelOutput: self)
    }
    
    func homeBottomNavigationPanelModule() -> AnyView {
        return homeBottomNavigationPanelModuleAssembly.make(homePath: editorPath, output: self)
    }

    func changeSourceModule(data: WidgetChangeSourceSearchModuleModel) -> AnyView {
        return newSearchModuleAssembly.widgetChangeSourceSearchModule(data: data)
    }
    
    func changeTypeModule(data: WidgetTypeModuleChangeModel) -> AnyView {
        return widgetTypeModuleAssembly.makeChangeType(data: data)
    }
    
    func searchModule(data: SearchModuleModel) -> AnyView {
        return searchModuleAssembly.makeObjectSearch(data: data)
    }
    
    func createWidgetModule(data: CreateWidgetCoordinatorModel) -> AnyView {
        return createWidgetCoordinatorAssembly.make(data: data)
    }
    
    func createSpaceSwitchModule() -> AnyView {
        return spaceSwitchCoordinatorAssembly.make()
    }
    
    func createSpaceSeetingsModule() -> AnyView {
        return spaceSettingsCoordinatorAssembly.make()
    }

    func createSharingModule() -> AnyView {
        return shareCoordinatorAssembly.make()
    }

    func editorModule(data: EditorScreenData) -> AnyView {
        return editorCoordinatorAssembly.make(data: data)
    }

    func createObjectWithTypeModule() -> AnyView {
        AnytypeAnalytics.instance().logOnboardingTooltip(tooltip: .selectType)
        return objectTypeSearchModuleAssembly.objectTypeSearchForCreateObject(
            spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId
        ) { [weak self] type in
            AnytypeAnalytics.instance().logSelectObjectType(type.analyticsType, route: .longTap)
            self?.showCreateObjectWithType = false
            self?.createAndShowNewPage(type: type)
        }
    }

    // MARK: - HomeWidgetsModuleOutput
    
    // MARK: - CommonWidgetModuleOutput
        
    func onObjectSelected(screenData: EditorScreenData) {
        openObject(screenData: screenData)
    }
    
    func onChangeSource(widgetId: String, context: AnalyticsWidgetContext) {
        showChangeSourceData = WidgetChangeSourceSearchModuleModel(
            widgetObjectId: activeWorkspaceStorage.workspaceInfo.widgetsId,
            spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId,
            widgetId: widgetId,
            context: context,
            onFinish: { [weak self] in
                self?.showChangeSourceData = nil
            }
        )
    }

    func onChangeWidgetType(widgetId: String, context: AnalyticsWidgetContext) {
        showChangeTypeData = WidgetTypeModuleChangeModel(
            widgetObjectId: activeWorkspaceStorage.workspaceInfo.widgetsId,
            widgetId: widgetId,
            context: context,
            onFinish: { [weak self] in
                self?.showChangeTypeData = nil
            }
        )
    }
    
    func onAddBelowWidget(widgetId: String, context: AnalyticsWidgetContext) {
        showCreateWidgetData = CreateWidgetCoordinatorModel(
            widgetObjectId: activeWorkspaceStorage.workspaceInfo.widgetsId,
            position: .below(widgetId: widgetId),
            context: context
        )
    }
    
    func onSpaceSelected() {
        showSpaceSettings.toggle()
    }
    
    // MARK: - HomeBottomPanelModuleOutput
    
    func onCreateWidgetSelected(context: AnalyticsWidgetContext) {
        showCreateWidgetData = CreateWidgetCoordinatorModel(
            widgetObjectId: activeWorkspaceStorage.workspaceInfo.widgetsId,
            position: .end,
            context: context
        )
    }
    
    func onSearchSelected() {
        AnytypeAnalytics.instance().logScreenSearch()
        showSearchData = SearchModuleModel(
            spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId,
            title: nil,
            onSelect: { [weak self] data in
                AnytypeAnalytics.instance().logSearchResult()
                self?.showSearchData = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    self?.openObject(screenData: data.editorScreenData)
                }
            }
        )
    }
    
    func onCreateObjectSelected(screenData: EditorScreenData) {
        openObject(screenData: screenData)
    }

    func onProfileSelected() {
        showSpaceSwitch.toggle()
    }
    
    // MARK: - EditorBrowserDelegate
    
    func onCreateObjectWithTypeSelected() {
        showCreateObjectWithType.toggle()
    }
    
    // MARK: - HomeBottomNavigationPanelModuleOutput

    func onHomeSelected() {
        editorPath.popToRoot()
    }

    func onForwardSelected() {
        editorPath.pushFromHistory()
    }

    func onBackwardSelected() {
        editorPath.pop()
    }

    // MARK: - Private
    
    private func openObject(screenData: EditorScreenData) {
//        editorPath.push(screenData, delegate: self)
        editorPath.push(screenData)
    }
    
    private func createAndShowNewPage() {
        Task {
            let details = try await dashboardService.createNewPage(spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId)
            AnytypeAnalytics.instance().logCreateObject(objectType: details.analyticsType, route: .navigation, view: .home)
            openObject(screenData: details.editorScreenData())
        }
    }

    private func createAndShowNewPage(type: ObjectType) {
        Task {
            let details = try await dashboardService.createNewPage(
                spaceId: activeWorkspaceStorage.workspaceInfo.accountSpaceId,
                typeUniqueKey: type.uniqueKey,
                templateId: type.defaultTemplateId
            )
            AnytypeAnalytics.instance().logCreateObject(objectType: details.analyticsType, route: .navigation, view: .home)
            openObject(screenData: details.editorScreenData())
        }
    }
    
    private func handleAppAction(action: AppAction) {
        switch action {
        case .createObject:
            createAndShowNewPage()
        case .showSharingExtension:
            showSharing = true
        case .spaceSelection:
            navigationContext.dismissAllPresented(animated: true, completion: { [weak self] in
                self?.editorBrowserCoordinator.dismissAllPages()
                self?.showSpaceSwitch = true
            })
        }
    }
}
