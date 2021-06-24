import UIKit
import BlocksModels
import SafariServices
import Combine

typealias FilePickerModel = CommonViews.Pickers.File.Picker.ViewModel
typealias MediaPickerModel = MediaPicker.ViewModel

protocol EditorRouterProtocol {
    
    func showPage(with id: BlockId)
    func openUrl(_ url: URL)
    func showBookmark(model: BlockActiveRecordModelProtocol, completion: @escaping (URL) -> ())
    
    func showFilePicker(model: FilePickerModel)
    func showImagePicker(model: MediaPickerModel)
    
    func saveFile(fileURL: URL)
    
    func showCodeLanguageView(languages: [String], completion: @escaping (String) -> Void)
    
    func showStyleMenu(block: BlockModelProtocol, viewModel: BaseBlockViewModel)
}


protocol PresentingViewController: UIViewController, EditorModuleDocumentViewInput {}

final class EditorRouter: EditorRouterProtocol {
    private weak var preseningViewController: PresentingViewController?
    private let fileRouter: FileRouter

    init(preseningViewController: PresentingViewController?) {
        self.preseningViewController = preseningViewController
        self.fileRouter = FileRouter(fileLoader: FileLoader(), viewController: preseningViewController)
    }

    /// Show page
    func showPage(with id: BlockId) {
        let newEditorViewController = EditorAssembly.build(id: id)
        
        preseningViewController?.navigationController?.pushViewController(
            newEditorViewController,
            animated: true
        )
    }
    
    func openUrl(_ url: URL) {
        guard url.containsHttpProtocol else {
            return
        }
        
        let safariController = SFSafariViewController(url: url)
        preseningViewController?.present(safariController, animated: true, completion: nil)
    }
    
    func showBookmark(model: BlockActiveRecordModelProtocol, completion: @escaping (URL) -> ()) {
        let viewModel = BookmarkToolbarViewModel(model: model, completion: completion)
        let controller = BookmarkViewController(model: viewModel)
        viewModel.controller = controller
        preseningViewController?.present(controller, animated: true, completion: nil)
    }
    
    func showFilePicker(model: FilePickerModel) {
        let vc = CommonViews.Pickers.File.Picker(model)
        preseningViewController?.present(vc, animated: true, completion: nil)
    }
    
    func showImagePicker(model: MediaPickerModel) {
        let vc = MediaPicker(viewModel: model)
        preseningViewController?.present(vc, animated: true, completion: nil)
    }
    
    func saveFile(fileURL: URL) {
        fileRouter.saveFile(fileURL: fileURL)
    }
    
    func showCodeLanguageView(languages: [String], completion: @escaping (String) -> Void) {
        let searchListViewController = SearchListViewController(items: languages, completion: completion)
        searchListViewController.modalPresentationStyle = .pageSheet
        preseningViewController?.present(searchListViewController, animated: true)
    }
    
    func showStyleMenu(block: BlockModelProtocol, viewModel: BaseBlockViewModel) {
        preseningViewController?.showStyleMenu(blockModel: block, blockViewModel: viewModel)
    }
}
