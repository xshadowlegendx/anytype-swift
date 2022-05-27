import UIKit
import SwiftUI

final class RelationBlockViewDepricated: UIView, BlockContentView, ObservableObject {
    @Published var heightConstraint: NSLayoutConstraint!
    @Published var relation: Relation?
    @Published var actionOnValue: (() -> Void)?

    // MARK: - Views

    fileprivate lazy var relationView = RelationView(delegate: self)
    private let container = UIView()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    func update(with configuration: DepricatedRelationBlockContentConfiguration) {
        relation = configuration.relation
        actionOnValue = configuration.actionOnValue

    }

    // MARK: - Setup view

    func setupLayout() {
        let relationsView = relationView.asUIView()

        insertSubview(relationsView, at: 0)

        relationsView.layoutUsing.anchors {
            heightConstraint = $0.height.equal(to: 32)
            $0.pinToSuperview()
        }
    }
}

private extension RelationBlockViewDepricated {

    struct RelationView: View {
        @State private var width: CGFloat = .zero
        @State private var height: CGFloat = .zero
        @ObservedObject var delegate: RelationBlockViewDepricated

        var body: some View {
            if let relation = delegate.relation {
                HStack(spacing: 2) {
                    AnytypeText(relation.name, style: .relation1Regular, color: .textSecondary)
                        .padding([.top], 5)
                        .frame(width: width * 0.4, height:  height, alignment: .topLeading)
                    RelationValueView(relation: RelationItemModel(relation: relation), style: .regular(allowMultiLine: true)) {
                        delegate.actionOnValue?()
                    }
                        .padding([.top], 5)
                        .if(height > LayoutConstants.minHeight) {
                            $0.padding(.bottom, 13)
                        }
                        .frame(maxWidth: .infinity, minHeight: LayoutConstants.minHeight, alignment: .topLeading)
                        .fixedSize(horizontal: false, vertical: true)
                        .readSize {
                            height = $0.height
                            delegate.heightConstraint.constant = height
                        }
                }
                .readSize { width = $0.width }
            }
        }

        private enum LayoutConstants {
            static let minHeight: CGFloat = 32
        }
    }
}
