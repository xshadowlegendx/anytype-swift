import Foundation
import Combine
import Kingfisher

final class UnsplashViewModel: GridItemViewModelProtocol {
    typealias Item = UnsplashItemViewModel
    typealias Section = GridItemSection<Item>

    let searchAvailability: SearchAvaliability = .search(placeholder: "Search".localized)
    let onItemSelect: (UnsplashItem) -> ()

    private var unsplashItems = [UnsplashItem]() {
        didSet {
            sections = backgroundSections()
        }
    }
    private let unsplashService: UnsplashServiceProtocol
    private(set) var isLoading: Bool = true
    private var searchSubscription: AnyCancellable?

    @Published var sections = [Section]()

    init(
        onItemSelect: @escaping (UnsplashItem) -> (),
        unsplashService: UnsplashServiceProtocol
    ) {
        self.onItemSelect = onItemSelect
        self.unsplashService = unsplashService

        searchImages(query: "")
    }

    func didSelectItem(item: UnsplashItemViewModel) {
        onItemSelect(item.item)
    }

    func didChangeSearchQuery(query: String) {
        searchImages(query: query)
    }

    private func searchImages(query: String) {
        isLoading = true
        
        searchSubscription = unsplashService
            .searchUnsplashImages(query: query)
            .receiveOnMain()
            .sinkWithResult { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let items): self?.unsplashItems = items
                case .failure: break
                }
            }
    }

    private func backgroundSections() -> [Section] {
        let items = unsplashItems.map(UnsplashItemViewModel.init(item:))

        return [Section(title: nil, items: items)]
    }
}
