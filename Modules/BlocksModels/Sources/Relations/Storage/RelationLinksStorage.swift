import Foundation
import AnytypeCore

public final class RelationLinksStorage: RelationLinksStorageProtocol {
    
    private var storage = SynchronizedArray<RelationLink>()
    
    public init() {}
    
    public var relationLinks: [RelationLink] {
        storage.array
    }
    
    public func set(relationLinks: [RelationLink]) {
        storage = SynchronizedArray<RelationLink>(array: relationLinks)
    }
    
    public func amend(relationLinks: [RelationLink]) {
        relationLinks.forEach { relationLink in
            let index = storage.array.firstIndex { $0.id == relationLink.id }
            if let index = index {
                storage[index] = relationLink
            } else {
                storage.append(relationLink)
            }
        }
    }
    
    public func remove(relationIds: [String]) {
        storage.removeAll {
            relationIds.contains($0.id)
        }
    }
    
    public func contains(relationKey: String) -> Bool {
        storage.array.contains { $0.key == relationKey }
    }
}
