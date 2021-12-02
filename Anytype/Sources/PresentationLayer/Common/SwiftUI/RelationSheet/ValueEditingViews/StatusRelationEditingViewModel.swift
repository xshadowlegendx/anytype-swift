import Foundation
import SwiftUI
import BlocksModels

final class StatusRelationEditingViewModel: ObservableObject {
    
    let allStatuses: [RelationValue.Status]
    @Published var selectedStatus: RelationValue.Status?
    
    private let key: String
    private let service: DetailsServiceProtocol
    
    init(
        relationOptions: [RelationMetadata.Option],
        selectedStatus: RelationValue.Status?,
        key: String,
        service: DetailsServiceProtocol
    ) {
        self.allStatuses = relationOptions.map { RelationValue.Status(option: $0) }
        self.selectedStatus = selectedStatus
        self.key = key
        self.service = service
    }
    
}

extension StatusRelationEditingViewModel: RelationEditingViewModelProtocol {
    
    func saveValue() {
        
    }
    
    func makeView() -> AnyView {
        AnyView(StatusRelationEditingView(viewModel: self))
    }
    
}
