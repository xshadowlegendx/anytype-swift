import Foundation
import SwiftUI

enum PageBlockViewEvents {
    case pageDetailsViewModelDidSet
}

/// Base View Model that all ToolsBlocksViews.BlockViewModel will inherit from.
/// Add common behavior to this class.
///
class PageBlockViewModel: BaseBlockViewModel {
    /// This DetailsViewModel could be extracted somewhere.
    /// Somewhere near EventHandler.
    private(set) var pageDetailsViewModel: DetailsActiveModel?
    
    // MARK: Subclassing
    func onIncoming(event: PageBlockViewEvents) {}

    func configured(pageDetailsViewModel: DetailsActiveModel?) -> Self {
        self.pageDetailsViewModel = pageDetailsViewModel
        self.onIncoming(event: .pageDetailsViewModelDidSet)
        
        return self
    }
}
