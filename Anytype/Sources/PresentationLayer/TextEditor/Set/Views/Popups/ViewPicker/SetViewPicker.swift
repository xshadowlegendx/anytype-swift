import SwiftUI

struct SetViewPicker: View {
    @StateObject var viewModel: SetViewPickerViewModel
    @State private var editMode = EditMode.inactive
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            DragIndicator()
            content
        }
        .frame(height: 358)
        .background(Color.Background.secondary)
    }
    
    private var content: some View {
        NavigationView {
            viewsList
                .navigationTitle(Loc.views)
                .navigationBarTitleDisplayMode(.inline)
                .environment(\.editMode, $editMode)
                .onChange(of: viewModel.rows) { newValue in
                    if editMode == .active && viewModel.rows.count == 0 {
                        editMode = .inactive
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
    
    private var viewsList: some View {
        List {
            ForEach(viewModel.rows) {
                row(with: $0)
                    .if($0 != viewModel.rows.last) {
                        $0.divider()
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .deleteDisabled(viewModel.disableDeletion)
            }
            .onMove { from, to in
                viewModel.move(from: from, to: to)
            }
            .onDelete {
                viewModel.delete($0)
            }
            .listRowBackground(Color.Background.secondary)
        }
        .listStyle(.plain)
        .buttonStyle(BorderlessButtonStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
                    .foregroundColor(Color.Button.active)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
            }
        }
        .bounceBehaviorBasedOnSize()
        .background(Color.Background.secondary)
    }
    
    private var addButton: some View {
        Group {
            if editMode == .inactive {
                Button {
                    viewModel.addButtonTapped()
                } label: {
                    Image(asset: .X32.plus).foregroundColor(.Button.active)
                }
            }
        }
    }
    
    private func row(with configuration: SetViewRowConfiguration) -> some View {
        SetViewRow(configuration: configuration, onTap: {
            presentationMode.wrappedValue.dismiss()
            configuration.onTap()
        })
        .environment(\.editMode, $editMode)
        .animation(nil, value: editMode)
    }
}
    
