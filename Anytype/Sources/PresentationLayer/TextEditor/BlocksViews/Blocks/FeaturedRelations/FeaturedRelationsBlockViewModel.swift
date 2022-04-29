import Foundation
import UIKit
import BlocksModels

#warning("Check if block updates when featuredRelations is changed. Waiting for new imp of flow layout")
struct FeaturedRelationsBlockViewModel: BlockViewModelProtocol {
    let indentationLevel: Int = 0
    let info: BlockInformation
    let type: String
    var featuredRelations: [Relation]
    let blockDelegate: BlockDelegate
    let onRelationTap: (Relation) -> Void
    
    var hashable: AnyHashable {
        [
            indentationLevel,
            info,
            type,
            featuredRelations
        ] as [AnyHashable]
    }
    
    init(
        info: BlockInformation,
        featuredRelation: [Relation],
        type: String,
        blockDelegate: BlockDelegate,
        onRelationTap: @escaping (Relation) -> Void
    ) {
        self.info = info
        self.featuredRelations = featuredRelation
        self.type = type
        self.blockDelegate = blockDelegate
        self.onRelationTap = onRelationTap
    }
    
    func makeContentConfiguration(maxWidth _: CGFloat) -> UIContentConfiguration {
        FeaturedRelationsBlockContentConfiguration(
            featuredRelations: featuredRelations.map(RelationItemModel.init),
            type: type,
            alignment: info.alignment.asNSTextAlignment,
            onRelationTap: { item in
                featuredRelations
                    .first { $0.id == item.id }
                    .map(onRelationTap)
            },
            heightDidChanged: { blockDelegate.textBlockSetNeedsLayout() }
        ).cellBlockConfiguration(
            indentationSettings: .init(with: info.configurationData),
            dragConfiguration: nil
        )
    }
    
    func didSelectRowInTableView(editorEditingState: EditorEditingState) {}
}
