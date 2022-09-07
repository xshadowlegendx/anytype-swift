import BlocksModels
import CoreGraphics
import Combine
import AnytypeCore
import UIKit

final class SearchNewRelationViewModel: ObservableObject {
    
    @Published private(set) var searchData: [SearchNewRelationSectionType] = []

    // MARK: - Private variables
    
    // Used for exclude relations that already has in object
    private let usedObjectRelationsKeys: Set<String>
    private let relationService: RelationsServiceProtocol
    private weak var output: SearchNewRelationModuleOutput?
    
    // MARK: - Initializers
    
    init(
        objectRelations: ParsedRelations,
        relationService: RelationsServiceProtocol,
        output: SearchNewRelationModuleOutput?
    ) {
        self.relationService = relationService
        self.output = output

        usedObjectRelationsKeys = Set(objectRelations.all.map { $0.key })
    }
    
}

// MARK: - View model methods

extension SearchNewRelationViewModel {
    
    func search(text: String) {
        AnytypeAnalytics.instance().logSearchQuery(.menuSearch, length: text.count)
        
        let newSearchData = obtainAvailbaleRelationList()

        guard !text.isEmpty else {
            searchData = newSearchData
            return
        }

        newSearchData.forEach { section in
            guard case let .addFromLibriry(relationsMetadata) = section else { return }
            searchData.removeAll()

            let filteredRelationsMetadata = relationsMetadata.filter { relationDetails in
                relationDetails.name.range(of: text, options: .caseInsensitive) != nil
            }
            
            searchData.append(.createNewRelation)

            if filteredRelationsMetadata.isNotEmpty {
                searchData.append(.addFromLibriry(filteredRelationsMetadata))
            }
        }
    }

    func obtainAvailbaleRelationList() -> [SearchNewRelationSectionType] {
        let relatonsMetadata = relationService.availableRelations().filter {
            !$0.isHidden && !usedObjectRelationsKeys.contains($0.key)
        }
        
        return [.createNewRelation, .addFromLibriry(relatonsMetadata)]
    }

    func addRelation(_ relation: RelationDetails) {
        guard relationService.addRelation(relation: relation) else { return }
        UISelectionFeedbackGenerator().selectionChanged()
        output?.didAddRelation(relation)
    }

    
    func showAddRelation(searchText: String) {
        output?.didAskToShowCreateNewRelation(searchText: searchText)
    }
    
}
