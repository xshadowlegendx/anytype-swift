import Combine
import Services

@MainActor
protocol RelationSelectedOptionsModelProtocol {
    var selectionMode: RelationSelectionOptionsMode { get }
    var selectedOptionsIdsPublisher: AnyPublisher<[String], Never> { get }
    
    func onClear() async throws
    func optionSelected(_ optionId: String) async throws
    func removeRelationOption(_ optionId: String) async throws
    func removeRelationOptionFromSelectedIfNeeded(_ optionId: String) async throws
}

@MainActor
final class RelationSelectedOptionsModel: RelationSelectedOptionsModelProtocol {
    
    @Published private var selectedOptionsIds: [String] = []
    var selectedOptionsIdsPublisher: AnyPublisher<[String], Never> { $selectedOptionsIds.eraseToAnyPublisher() }
    
    let selectionMode: RelationSelectionOptionsMode
    
    private let objectId: String
    private let relationKey: String
    private let analyticsType: AnalyticsEventsRelationType
    
    @Injected(\.relationsService)
    private var relationsService: RelationsServiceProtocol
    
    init(
        objectId: String,
        selectionMode: RelationSelectionOptionsMode,
        selectedOptionsIds: [String],
        relationKey: String,
        analyticsType: AnalyticsEventsRelationType
    ) {
        self.objectId = objectId
        self.selectionMode = selectionMode
        self.selectedOptionsIds = selectedOptionsIds
        self.relationKey = relationKey
        self.analyticsType = analyticsType
    }
    
    func onClear() async throws {
        selectedOptionsIds = []
        try await relationsService.updateRelation(objectId: objectId, relationKey: relationKey, value: nil)
        logChanges()
    }
    
    func optionSelected(_ optionId: String) async throws {
        switch selectionMode {
        case .single:
            selectedOptionsIds = [optionId]
        case .multi:
            handleMultiOptionSelected(optionId)
        }
        
        try await relationsService.updateRelation(
            objectId: objectId,
            relationKey: relationKey,
            value: selectedOptionsIds.protobufValue
        )
        logChanges()
    }
    
    func removeRelationOption(_ optionId: String) async throws {
        try await relationsService.removeRelationOptions(ids: [optionId])
        try await removeRelationOptionFromSelectedIfNeeded(optionId)
    }
    
    func removeRelationOptionFromSelectedIfNeeded(_ optionId: String) async throws {
        if let index = selectedOptionsIds.firstIndex(of: optionId) {
            selectedOptionsIds.remove(at: index)
            try await relationsService.updateRelation(
                objectId: objectId,
                relationKey: relationKey,
                value: selectedOptionsIds.protobufValue
            )
        }
    }
    
    private func handleMultiOptionSelected(_ optionId: String) {
        if let index = selectedOptionsIds.firstIndex(of: optionId) {
            selectedOptionsIds.remove(at: index)
        } else {
            selectedOptionsIds.append(optionId)
        }
    }
    
    private func logChanges() {
        AnytypeAnalytics.instance().logChangeRelationValue(isEmpty: selectedOptionsIds.isEmpty, type: analyticsType)
    }
}
