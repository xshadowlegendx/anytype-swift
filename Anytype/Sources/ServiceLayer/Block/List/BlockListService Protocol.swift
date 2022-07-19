import BlocksModels
import ProtobufMessages

protocol BlockListServiceProtocol: AnyObject {
    func setDivStyle(blockIds: [BlockId], style: BlockDivider.Style)
    func setAlign(blockIds: [BlockId], alignment: LayoutAlignment)
    func setBackgroundColor(blockIds: [BlockId], color: MiddlewareColor)
    func setFields(fields: [Anytype_Rpc.Block.ListSetFields.Request.BlockField])
    func setBlockColor(blockIds: [BlockId], color: MiddlewareColor)
    
    func replace(blockIds: [BlockId], targetId: BlockId)
    func move(blockId: BlockId, targetId: BlockId, position: Anytype_Model_Block.Position)
    func moveToPage(blockId: BlockId, pageId: BlockId)
    func setLinkAppearance(blockIds: [BlockId], appearance: BlockLink.Appearance)
    func changeMarkup(blockIds: [BlockId], markType: MarkupType)
}
