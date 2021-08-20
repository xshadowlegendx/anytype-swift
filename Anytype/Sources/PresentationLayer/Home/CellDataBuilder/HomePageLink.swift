import BlocksModels

struct HomePageLink {
    let blockId: BlockId
    let targetBlockId: BlockId // Id of linked page
    let details: DetailsData?
    let linkStyle: BlockLink.Style
    
    var isLoading: Bool {
        details.isNil
    }
    
    var isArchived: Bool {
        details?.isArchived ?? false
    }
}
