import Foundation
import Combine
import BlocksModels
import ProtobufMessages
import Amplitude


class DashboardService: DashboardServiceProtocol {
    private let objectsService = ObjectActionsService()
    
    func createNewPage() -> BlockId? {
        Amplitude.instance().logEvent(AmplitudeEventsName.pageCreate)
        let defaultTypeUrl = ObjectTypeProvider.defaultObjectType.url
        return objectsService.createPage(
            contextId: "",
            targetId: "",
            details: [.name(""), .isDraft(true), .type()],
            details: [.name(""), .isDraft(true), ],
            position: .bottom,
            templateId: ""
        )
    }
}
