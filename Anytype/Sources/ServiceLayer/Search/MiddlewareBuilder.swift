import ProtobufMessages
import SwiftProtobuf

class MiddlewareBuilder {
    static func sort(relation: Relation, type: Anytype_Model_Block.Content.Dataview.Sort.TypeEnum) -> Anytype_Model_Block.Content.Dataview.Sort {
        var sort = Anytype_Model_Block.Content.Dataview.Sort()
        sort.relationKey = relation
        sort.type = type
        
        return sort
    }
    
    static func isArchivedFilter(isArchived: Bool) -> Anytype_Model_Block.Content.Dataview.Filter {
        var filter = Anytype_Model_Block.Content.Dataview.Filter()
        filter.condition = .equal
        filter.value = Google_Protobuf_Value(boolValue: isArchived)
        filter.relationKey = Relations.isArchived
        filter.operator = .and
        
        return filter
    }
    
    static func objectTypeFilter(type: ObjectType) -> Anytype_Model_Block.Content.Dataview.Filter {
        var filter = Anytype_Model_Block.Content.Dataview.Filter()
        filter.condition = .equal
        filter.value = Google_Protobuf_Value(stringValue: type.rawValue)
        filter.relationKey = Relations.type
        filter.operator = .and
        
        return filter
    }
}
