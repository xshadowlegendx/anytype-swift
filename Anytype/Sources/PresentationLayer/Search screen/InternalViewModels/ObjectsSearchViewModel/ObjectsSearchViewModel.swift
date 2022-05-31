import Foundation
import BlocksModels
import Combine
import SwiftUI

final class ObjectsSearchViewModel {
    
    let selectionMode: NewSearchViewModel.SelectionMode
    
    @Published private var rows: [ListRowConfiguration] = []
    
    private var objects: [ObjectDetails] = [] {
        didSet {
            rows = objects.asRowConfigurations(with: selectedObjectIds, selectionMode: selectionMode)
        }
    }
    
    private var selectedObjectIds: [String] = [] {
        didSet {
            rows = objects.asRowConfigurations(with: selectedObjectIds, selectionMode: selectionMode)
        }
    }
    
    private let interactor: ObjectsSearchInteractorProtocol
    
    init(selectionMode: NewSearchViewModel.SelectionMode, interactor: ObjectsSearchInteractorProtocol) {
        self.selectionMode = selectionMode
        self.interactor = interactor
    }
    
}

extension ObjectsSearchViewModel: NewInternalSearchViewModelProtocol {
    
    var viewStatePublisher: AnyPublisher<NewSearchViewState, Never> {
        $rows.map { rows -> NewSearchViewState in
            NewSearchViewState.resultsList(NewSearchView.ListModel.plain(rows: rows))
        }.eraseToAnyPublisher()
    }
    
    func search(text: String) {
        self.objects = interactor.search(text: text)
    }
    
    func handleRowsSelection(ids: [String]) {
        self.selectedObjectIds = ids
    }
    
}

private extension Array where Element == ObjectDetails {

    func asRowConfigurations(with selectedIds: [String], selectionMode: NewSearchViewModel.SelectionMode) -> [ListRowConfiguration] {
        map { details in
            ListRowConfiguration(
                id: details.id,
                contentHash: details.hashValue
            ) {
                AnyView(
                    SearchObjectRowView(
                        viewModel: SearchObjectRowView.Model(details: details),
                        selectionIndicatorViewModel: selectionMode.asSelectionIndicatorViewModel(
                            details: details,
                            selectedIds: selectedIds
                        )
                    )
                )
            }
        }
    }
}

private extension NewSearchViewModel.SelectionMode {
    
    func asSelectionIndicatorViewModel(details: ObjectDetails, selectedIds: [String]) -> SelectionIndicatorView.Model? {
        switch self {
        case .multipleItems:
            return SelectionIndicatorViewModelBuilder.buildModel(id: details.id, selectedIds: selectedIds)
        case .singleItem:
            return nil
        }
    }
}

private extension SearchObjectRowView.Model {
    
    init(details: ObjectDetails) {
        let title = details.title
        self.icon = {
            if details.layout == .todo {
                return .todo(details.isDone)
            } else {
                return details.icon.flatMap { .icon($0) } ?? .placeholder(title.first)
            }
        }()
        self.title = title
        self.subtitle = details.objectType.name
    }
    
}
