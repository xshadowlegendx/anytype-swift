import BlocksModels
import AnytypeCore
import UIKit

protocol AttachmentRouterProtocol {
    func openImage(_ imageContext: FilePreviewContext)
}

protocol EditorRouterProtocol: AnyObject, AttachmentRouterProtocol {
    func showAlert(alertModel: AlertModel)
    func showFailureToast(message: String)
    func showPage(data: EditorScreenData)
    func replaceCurrentPage(with data: EditorScreenData)
    
    func openUrl(_ url: URL)
    func showBookmarkBar(completion: @escaping (AnytypeURL) -> ())
    func showLinkMarkup(url: AnytypeURL?, completion: @escaping (AnytypeURL?) -> Void)
    
    func showFilePicker(model: Picker.ViewModel)
    func showImagePicker(contentType: MediaPickerContentType, onSelect: @escaping (NSItemProvider?) -> Void)
    
    func saveFile(fileURL: URL, type: FileContentType)
    
    func showCodeLanguage(blockId: BlockId)
    
    func showStyleMenu(
        information: BlockInformation,
        restrictions: BlockRestrictions,
        didShow: @escaping (UIView) -> Void,
        onDismiss: @escaping () -> Void
    )

    func showMarkupBottomSheet(
        selectedBlockIds: [BlockId],
        viewDidClose: @escaping () -> Void
    )
    
    func showSettings()
    func showCoverPicker()
    func showIconPicker()
    func showTextIconPicker(contextId: BlockId, objectId: BlockId)
    
    func showMoveTo(onSelect: @escaping (BlockId) -> ())
    func showLinkTo(onSelect: @escaping (ObjectDetails) -> ())
    func showSearch(onSelect: @escaping (EditorScreenData) -> ())

    func showTypes(selectedObjectId: BlockId?, onSelect: @escaping (BlockId) -> ())
    func showTypesForEmptyObject(selectedObjectId: BlockId?, onSelect: @escaping (BlockId) -> ())
    func showSources(selectedObjectId: BlockId?, onSelect: @escaping (BlockId) -> ())
    func showObjectPreview(
        blockLinkState: BlockLinkState,
        onSelect: @escaping (BlockLink.Appearance) -> Void
    )
    
    func showRelationValueEditingView(key: String)
    func showRelationValueEditingView(objectId: BlockId, relation: Relation)
    func showAddNewRelationView(onSelect: ((RelationDetails, _ isNew: Bool) -> Void)?)

    func showLinkContextualMenu(inputParameters: TextBlockURLInputParameters)

    func showWaitingView(text: String)
    func hideWaitingView()
    
    func closeEditor()
    
    func presentSheet(_ vc: UIViewController)
    func presentFullscreen(_ vc: UIViewController)
    func setNavigationViewHidden(_ isHidden: Bool, animated: Bool)
    
    func showTemplatesPopupIfNeeded(
        document: BaseDocumentProtocol,
        templatesTypeId: ObjectTypeId,
        onShow: (() -> Void)?
    )
    func showTemplatesPopupWithTypeCheckIfNeeded(
        document: BaseDocumentProtocol,
        templatesTypeId: ObjectTypeId,
        onShow: (() -> Void)?
    )
    
    func showViewPicker(
        setDocument: SetDocumentProtocol,
        dataviewService: DataviewServiceProtocol,
        showViewTypes: @escaping RoutingAction<DataviewView?>
    )

    func showCreateObject(pageId: BlockId)
    func showCreateBookmarkObject()
    
    func showSetSettings(onSettingTap: @escaping (EditorSetSetting) -> Void)
    func showViewTypes(
        dataView: BlockDataview,
        activeView: DataviewView?,
        source: [String],
        dataviewService: DataviewServiceProtocol
    )
    func showViewSettings(setDocument: SetDocumentProtocol, dataviewService: DataviewServiceProtocol)
    func dismissSetSettingsIfNeeded()
    func showSorts(setDocument: SetDocumentProtocol, dataviewService: DataviewServiceProtocol)
    func showRelationSearch(relationsDetails: [RelationDetails], onSelect: @escaping (RelationDetails) -> Void)
    func showFilterSearch(filter: SetFilter, onApply: @escaping (SetFilter) -> Void)
    
    func showFilters(setDocument: SetDocumentProtocol, dataviewService: DataviewServiceProtocol)
    func showColorPicker(
        onColorSelection: @escaping (ColorView.ColorItem) -> Void,
        selectedColor: UIColor?,
        selectedBackgroundColor: UIColor?
    )
    
    func showCardSizes(size: DataviewViewSize, onSelect: @escaping (DataviewViewSize) -> Void)
    func showCovers(setDocument: SetDocumentProtocol, onSelect: @escaping (String) -> Void)
    
    func showGroupByRelations(
        selectedRelationKey: String,
        relations: [RelationDetails],
        onSelect: @escaping (String) -> Void
    )
    
    func showKanbanColumnSettings(
        hideColumn: Bool,
        selectedColor: BlockBackgroundColor?,
        onSelect: @escaping (Bool, BlockBackgroundColor?) -> Void
    )
}
