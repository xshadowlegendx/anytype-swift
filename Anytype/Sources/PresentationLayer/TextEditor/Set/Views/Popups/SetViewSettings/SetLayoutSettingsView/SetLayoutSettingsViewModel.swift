import SwiftUI
import Services
import Combine

@MainActor
final class SetLayoutSettingsViewModel: ObservableObject {
    @Published var selectedType: DataviewViewType = .table
    
    var types: [SetViewTypeConfiguration] {
        updatedTypes()
    }
    var settings: [EditorSetViewSettingsItem] {
        updatedSettings()
    }
    
    private let setDocument: SetDocumentProtocol
    private weak var output: SetLayoutSettingsCoordinatorOutput?
    
    private var activeView: DataviewView = .empty
    private var cancellable: Cancellable?
    private let dataviewService: DataviewServiceProtocol
    
    init(
        setDocument: SetDocumentProtocol,
        output: SetLayoutSettingsCoordinatorOutput?,
        dataviewService: DataviewServiceProtocol
    ) {
        self.setDocument = setDocument
        self.output = output
        self.dataviewService = dataviewService
        self.setupSubscription()
    }
    
    private func setupSubscription() {
        cancellable = setDocument.activeViewPublisher.sink { [weak self] activeView in
            guard let self else { return }
            self.activeView = activeView
            self.selectedType = activeView.type
        }
    }
    
    private func updatedTypes() -> [SetViewTypeConfiguration] {
        DataviewViewType.allCases.compactMap { viewType in
            guard viewType.isSupported else { return nil }
            let selected = viewType == selectedType
            return SetViewTypeConfiguration(
                id: viewType.name,
                icon: viewType.icon(selected: selected),
                name: viewType.name,
                isSelected: selected,
                onTap: { [weak self] in
                    guard let self else { return }
                    self.selectedType = viewType
                    let activeView = self.activeView.updated(type: selectedType)
                    self.updateView(activeView)
                }
            )
        }
    }
    
    private func updatedSettings() -> [EditorSetViewSettingsItem] {
        selectedType.settings.compactMap { setting in
            switch setting {
            case .icon:
                return .toggle(EditorSetViewSettingsToggleItem(
                    title: Loc.icon,
                    isSelected: !setDocument.activeView.hideIcon,
                    onChange: { [weak self] show in
                        guard let self else { return }
                        let activeView = activeView.updated(hideIcon: !show)
                        self.updateView(activeView)
                    }
                ))
            case .cardSize:
                return .value(EditorSetViewSettingsValueItem(
                    title: Loc.Set.View.Settings.CardSize.title,
                    value: setDocument.activeView.cardSize.value,
                    onTap: { [weak self] in
        //                self?.showCardSizes()
                    }
                ))
            case .imagePreview:
                return .value(EditorSetViewSettingsValueItem(
                    title: Loc.Set.View.Settings.ImagePreview.title,
                    value: imagePreviewValue(),
                    onTap: { [weak self] in
                        self?.onImagePreviewTap()
                    }
                ))
            case .fitImage:
                return .toggle(EditorSetViewSettingsToggleItem(
                    title: Loc.Set.View.Settings.ImageFit.title,
                    isSelected: setDocument.activeView.coverFit,
                    onChange: { [weak self] fit in
                        guard let self else { return }
                        let activeView = activeView.updated(coverFit: fit)
                        self.updateView(activeView)
                    }
                ))
            case .colorColumns:
                return .toggle(EditorSetViewSettingsToggleItem(
                    title: Loc.Set.View.Settings.GroupBackgroundColors.title,
                    isSelected: setDocument.activeView.groupBackgroundColors,
                    onChange: { [weak self] colored in
                        guard let self else { return }
                        let activeView = activeView.updated(groupBackgroundColors: colored)
                        self.updateView(activeView)
                    }
                ))
            case .groupBy:
                return .value(EditorSetViewSettingsValueItem(
                    title: Loc.Set.View.Settings.GroupBy.title,
                    value: groupByValue(with: setDocument.activeView.groupRelationKey),
                    onTap: { [weak self] in
        //                self?.showGroupByRelations()
                    }
                ))
            }
        }
        
    }
    
    private func onImagePreviewTap() {
        output?.onImagePreviewTap { [weak self] key in
            guard let self else { return }
            let activeView = activeView.updated(coverRelationKey: key)
            self.updateView(activeView)
        }
    }
    
    private func updateView(_ activeView: DataviewView) {
        if activeView.type != selectedType {
            AnytypeAnalytics.instance().logChangeViewType(type: selectedType.stringValue, objectType: setDocument.analyticsType)
        }
        Task {
            try await dataviewService.updateView(activeView)
        }
    }
    
    private func groupByValue(with key: String) -> String {
        setDocument.dataViewRelationsDetails.first { relation in
            relation.key == key
        }?.name ?? key
    }
    
    private func imagePreviewValue() -> String {
        imagePreviewValueFromCovers() ?? imagePreviewValueFromRelations() ?? ""
    }
    
    private func imagePreviewValueFromCovers() -> String? {
        SetViewSettingsImagePreviewCover.allCases.first { cover in
            return cover.rawValue == setDocument.activeView.coverRelationKey
        }?.title
    }
    
    private func imagePreviewValueFromRelations() -> String? {
        setDocument.dataViewRelationsDetails.first { relationDetails in
            return relationDetails.key == setDocument.activeView.coverRelationKey
        }?.name
    }
}
