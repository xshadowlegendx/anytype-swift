import ProtobufMessages
import Combine

final class SearchService {
    private var subscriptions = [AnyCancellable]()
    
    func searchArchivedPages(completion: @escaping ([SearchResult]) -> ()) {
        let sort = MiddlewareBuilder.sort(
            relation: Relations.lastModifiedDate,
            type: .desc
        )
        
        let filter = MiddlewareBuilder.isArchivedFilter(isArchived: true)
        
        makeRequest(
            filters: [filter],
            sorts: [sort],
            fullText: "",
            offset: 0,
            limit: 100,
            objectTypeFilter: [],
            keys: [],
            completion: completion
        )
    }
    
    func searchRecentPages(completion: @escaping ([SearchResult]) -> ()) {
        let sort = MiddlewareBuilder.sort(
            relation: Relations.lastOpenedDate,
            type: .desc
        )
        let filter = MiddlewareBuilder.isArchivedFilter(isArchived: false)
        
        makeRequest(
            filters: [filter],
            sorts: [sort],
            fullText: "",
            offset: 0,
            limit: 30,
            objectTypeFilter: [ObjectType.set.rawValue, ObjectType.page.rawValue],
            keys: [],
            completion: completion
        )
    }
    
    private func makeRequest(
        filters: [Anytype_Model_Block.Content.Dataview.Filter],
        sorts: [Anytype_Model_Block.Content.Dataview.Sort],
        fullText: String,
        offset: Int32,
        limit: Int32,
        objectTypeFilter: [String],
        keys: [String],
        completion: @escaping ([SearchResult]) -> ()
    ) {
        Anytype_Rpc.Object.Search.Service.invoke(
            filters: filters,
            sorts: sorts,
            fullText: fullText,
            offset: offset,
            limit: limit,
            objectTypeFilter: objectTypeFilter,
            keys: keys,
            queue: .main
        )
        .receiveOnMain()
        .sinkWithDefaultCompletion("Search") { response in
            completion(
                response.records.compactMap { SearchResult(fields: $0.fields) }
            )
        }
        .store(in: &subscriptions)
    }
}
