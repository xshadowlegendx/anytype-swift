import Foundation
import BlocksModels
import SwiftUI

extension Relation {
    
    struct Tag: RelationProtocol, Hashable, Identifiable {
        let id: String
        let key: String
        let name: String
        let isFeatured: Bool
        let isEditable: Bool
        let isBundled: Bool
        
        let selectedTags: [Option]
        #warning("Delete field")
        let allTags: [Option]
    }
    
}

extension Relation.Tag {
    
    struct Option: Hashable, Identifiable {
        let id: String
        let text: String
        let textColor: UIColor
        let backgroundColor: UIColor
        let scope: RelationOption.Scope
    }
    
}

extension Relation.Tag.Option {
    
    init(option: RelationOption) {
        self.id = option.id
        self.text = option.text
        self.textColor = MiddlewareColor(rawValue: option.color)
            .map { UIColor.Text.uiColor(from: $0) } ?? .textSecondary
        self.backgroundColor = MiddlewareColor(rawValue: option.color)
            .map { UIColor.TagBackground.uiColor(from: $0) } ?? .backgroundSecondary

        self.scope = option.scope
    }
    
}
