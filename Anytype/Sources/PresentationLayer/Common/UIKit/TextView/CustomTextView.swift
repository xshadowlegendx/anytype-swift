import Foundation
import UIKit
import Combine
import os
import BlocksModels

extension CustomTextView {
    struct Options {
        let createNewBlockOnEnter: Bool
        let autocorrect: Bool
    }
}


final class CustomTextView: UIView {
    
    weak var delegate: TextViewDelegate?
    weak var userInteractionDelegate: TextViewUserInteractionProtocol? {
        didSet {
            textView.userInteractionDelegate = userInteractionDelegate
        }
    }
    
    var textSize: CGSize?
    
    let editingToolbarAccessoryView = EditingToolbarView()
    let inputSwitcher = TextBlockAccessoryViewSwitcher()
    
    let options: Options

    private(set) lazy var textView: TextViewWithPlaceholder = {
        let textView = TextViewWithPlaceholder()
        textView.textContainer.lineFragmentPadding = 0.0
        textView.isScrollEnabled = false
        textView.backgroundColor = nil
        textView.autocorrectionType = options.autocorrect ? .yes : .no
        return textView
    }()

    private(set) lazy var menuActionsAccessoryView: SlashMenuView = {
        let dismissActionsMenu = { [weak self] in
            guard let self = self else { return }
            self.inputSwitcher.cleanupDisplayedView()
            self.inputSwitcher.showEditingBars(customTextView: self)
        }

        let actionViewRect = CGRect(origin: .zero, size: Constants.menuActionsViewSize)
        return SlashMenuView(
            frame: actionViewRect,
            menuItems: menuItemsBuilder.makeBlockActionsMenuItems(),
            slashMenuActionsHandler: slashMenuActionsHandler,
            actionsMenuDismissHandler: dismissActionsMenu
        )
    }()

    private(set) lazy var mentionView: MentionView = {
        let dismissActionsMenu = { [weak self] in
            guard let self = self else { return }
            self.inputSwitcher.cleanupDisplayedView()
            self.inputSwitcher.showEditingBars(customTextView: self)
        }
        return MentionView(
            frame: CGRect(origin: .zero, size: Constants.menuActionsViewSize),
            dismissHandler: dismissActionsMenu,
            mentionsSelectionHandler: mentionsSelectionHandler)
    }()
    
    private var firstResponderSubscription: AnyCancellable?

    private let menuItemsBuilder: BlockActionsBuilder
    private let slashMenuActionsHandler: SlashMenuActionsHandler
    private let mentionsSelectionHandler: (MentionObject) -> Void
    
    init(
        options: Options,
        menuItemsBuilder: BlockActionsBuilder,
        slashMenuActionsHandler: SlashMenuActionsHandler,
        mentionsSelectionHandler: @escaping (MentionObject) -> Void
    ) {
        self.options = options
        self.menuItemsBuilder = menuItemsBuilder
        self.slashMenuActionsHandler = slashMenuActionsHandler
        self.mentionsSelectionHandler = mentionsSelectionHandler
        super.init(frame: .zero)

        setupView()
        configureEditingToolbarHandler()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override vars
    
    override var intrinsicContentSize: CGSize {
        .zero
    }

}

// MARK: - BlockTextViewInput

extension CustomTextView: TextViewManagingFocus {
    
    func shouldResignFirstResponder() {
        _ = textView.resignFirstResponder()
    }

    func setFocus(_ focus: BlockFocusPosition?) {
        guard let focus = focus else { return }
        
        textView.setFocus(focus)
    }

    func obtainFocusPosition() -> BlockFocusPosition? {
        guard textView.isFirstResponder else { return nil }
        let caretLocation = textView.selectedRange.location
        if caretLocation == 0 {
            return .beginning
        }
        return .at(textView.selectedRange)
    }
}

// MARK: - Private extension

private extension CustomTextView {
    
    func setupView() {
        textView.delegate = self

        addSubview(textView) {
            $0.pinToSuperview()
        }
        
        firstResponderSubscription = textView.firstResponderChangePublisher
            .sink { [weak self] change in
                self?.delegate?.changeFirstResponderState(change)
            }
    }

    func configureEditingToolbarHandler() {
        self.editingToolbarAccessoryView.setActionHandler { [weak self] action in
            guard let self = self else { return }

            self.inputSwitcher.switchInputs(customTextView: self)

            switch action {
            case .slashMenu:
                self.textView.insertStringToAttributedString(
                    self.inputSwitcher.textToTriggerActionsViewDisplay
                )
                self.inputSwitcher.showAccessoryView(accessoryView: self.menuActionsAccessoryView,
                                                     textView: self.textView)
            case .multiActionMenu:
                self.userInteractionDelegate?.didReceiveAction(
                    .showMultiActionMenuAction
                )

            case .showStyleMenu:
                self.userInteractionDelegate?.didReceiveAction(.showStyleMenu)

            case .keyboardDismiss:
                UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
            case .mention:
                self.textView.insertStringToAttributedString(self.inputSwitcher.textToTriggerMentionViewDisplay)
                self.inputSwitcher.showAccessoryView(accessoryView: self.mentionView,
                                                     textView: self.textView)
            }
        }
    }
}

private extension CustomTextView {
    enum Constants {
        /// Minimum time interval to stay idle to handle consequent return key presses
        static let thresholdDelayBetweenConsequentReturnKeyPressing: CFTimeInterval = 0.5
        static let menuActionsViewSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.isFourInch ? 160 : 215
        )
    }
}
