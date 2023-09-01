import Services

protocol SetTemplatesInteractorProtocol {
    func isTemplatesAvailableFor(setObject: ObjectDetails) async throws -> Bool
    func isTemplatesAvailableFor(activeView: DataviewView) async throws -> Bool
}

final class SetTemplatesInteractor: SetTemplatesInteractorProtocol {
    private let templatesService: TemplatesServiceProtocol
    
    init(templatesService: TemplatesServiceProtocol) {
        self.templatesService = templatesService
    }
    
    func isTemplatesAvailableFor(setObject: ObjectDetails) async throws -> Bool {
        guard setObject.setOf.count == 1, let objectTypeId = setObject.setOf.first else {
            return false
        }
        return try await isTemplatesAvailableFor(objectTypeId: objectTypeId)
    }
    
    func isTemplatesAvailableFor(activeView: DataviewView) async throws -> Bool {
        let objectTypeId = activeView.defaultObjectTypeIDWithFallback
        return try await isTemplatesAvailableFor(objectTypeId: objectTypeId)
    }
    
    private func isTemplatesAvailableFor(objectTypeId: String) async throws -> Bool {
        let objectDetails = try await templatesService.objectDetails(objectId: objectTypeId)
        return objectDetails.setIsTemplatesAvailable
    }
}
