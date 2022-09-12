import Foundation
import BlocksModels
import AnytypeCore

extension RelationValueProvider {
    
    var pageCellTitle: String {
        switch layoutValue {
        case .note:
            return snippet
        default:
            return name
        }
    }

    var title: String {
        if isDeleted {
            return Loc.nonExistentObject
        }
        
        let title: String

        switch layoutValue {
        case .note:
            title = snippet
        default:
            title = name
        }

        return title.isEmpty ? Loc.untitled : title
    }
    
    var homeLayout: HomeCellData.TitleLayout {
        if FeatureFlags.bookmarksFlowP2 {
            switch objectIconImage {
            case .todo, .icon(.bookmark):
                return .horizontal
            default:
                return .vertical
            }
        } else {
            switch objectIconImage {
            case .todo:
                return .horizontal
            default:
                return .vertical
            }
        }
    }
    
    var mentionTitle: String {
        String(title.prefix(30)).replacingOccurrences(of: "\n", with: " ")
    }
}
