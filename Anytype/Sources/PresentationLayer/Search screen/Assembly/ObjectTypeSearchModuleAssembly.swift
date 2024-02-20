import Foundation
import Services
import SwiftUI
import AnytypeCore

protocol ObjectTypeSearchModuleAssemblyProtocol: AnyObject {
    func makeTypeSearchForNewObjectCreation(
        title: String,
        spaceId: String,
        onSelect: @escaping (_ type: ObjectType) -> Void
    ) -> AnyView
    
    func makeDefaultTypeSearch(
        title: String,
        spaceId: String,
        showPins: Bool,
        showLists: Bool,
        showFiles: Bool,
        onSelect: @escaping (_ type: ObjectType) -> Void
    ) -> AnyView
}

final class ObjectTypeSearchModuleAssembly: ObjectTypeSearchModuleAssemblyProtocol {
    
    private let uiHelpersDI: UIHelpersDIProtocol
    private let serviceLocator: ServiceLocator
    
    init(uiHelpersDI: UIHelpersDIProtocol, serviceLocator: ServiceLocator) {
        self.uiHelpersDI = uiHelpersDI
        self.serviceLocator = serviceLocator
    }
    
    func makeTypeSearchForNewObjectCreation(
        title: String,
        spaceId: String,
        onSelect: @escaping (_ type: ObjectType) -> Void
    ) -> AnyView {
        let model = ObjectTypeSearchViewModel(
            showPins: true,
            showLists: true,
            showFiles: false,
            spaceId: spaceId,
            workspaceService: serviceLocator.workspaceService(),
            typesService: serviceLocator.typesService(),
            objectTypeProvider: serviceLocator.objectTypeProvider(),
            toastPresenter: uiHelpersDI.toastPresenter(),
            pasteboardHelper: serviceLocator.pasteboardHelper(),
            onSelect: onSelect
        )
        
        return ObjectTypeSearchView(
            title: title,
            viewModel: model
        ).eraseToAnyView()
    }
    
    func makeDefaultTypeSearch(
        title: String,
        spaceId: String,
        showPins: Bool,
        showLists: Bool,
        showFiles: Bool,
        onSelect: @escaping (_ type: ObjectType) -> Void
    ) -> AnyView {
        if FeatureFlags.newTypePicker {
            let model = ObjectTypeSearchViewModel(
                showPins: showPins,
                showLists: showLists, 
                showFiles: showFiles,
                spaceId: spaceId,
                workspaceService: serviceLocator.workspaceService(),
                typesService: serviceLocator.typesService(),
                objectTypeProvider: serviceLocator.objectTypeProvider(),
                toastPresenter: uiHelpersDI.toastPresenter(), 
                pasteboardHelper: serviceLocator.pasteboardHelper(),
                onSelect: onSelect
            )
            
            return ObjectTypeSearchView(
                title: title,
                viewModel: model
            ).eraseToAnyView()
        } else {
            let interactor = Legacy_ObjectTypeSearchInteractor(
                spaceId: spaceId,
                typesService: serviceLocator.typesService(),
                workspaceService: serviceLocator.workspaceService(),
                objectTypeProvider: serviceLocator.objectTypeProvider(),
                showBookmark: true,
                showSetAndCollection: true, 
                showFiles: showFiles
            )
            
            let internalViewModel = Legacy_ObjectTypeSearchViewModel(
                interactor: interactor,
                toastPresenter: uiHelpersDI.toastPresenter(),
                selectedObjectId: nil,
                hideMarketplace: true,
                showDescription: false,
                onSelect: onSelect
            )
            let viewModel = NewSearchViewModel(
                title: Loc.createNewObject,
                searchPlaceholder: Loc.ObjectType.search,
                focusedBar: false,
                style: .default,
                itemCreationMode: .unavailable,
                internalViewModel: internalViewModel
            )
            
            return NewSearchView(viewModel: viewModel).eraseToAnyView()
        }
    }
}
