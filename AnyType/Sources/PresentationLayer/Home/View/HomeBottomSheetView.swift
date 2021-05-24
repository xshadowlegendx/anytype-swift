import SwiftUI

private struct HomeBottomSheetViewConfiguration {
    let cornerRadius: CGFloat = 16
    let snapRatio: CGFloat = 0.05
    let minHeightRatio: CGFloat = 0.55
    let maxHeight: CGFloat
    
    var minHeight: CGFloat {
        maxHeight * minHeightRatio
    }
    
    var snapDistance: CGFloat {
        maxHeight * snapRatio
    }
}

struct HomeBottomSheetView<Content: View>: View {
    private let content: Content
    private let config: HomeBottomSheetViewConfiguration

    init(
        maxHeight: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.config = HomeBottomSheetViewConfiguration(maxHeight: maxHeight)
    }
    
    @State private var isOpen: Bool = false
    
    private var offset: CGFloat {
        isOpen ? 0 : config.maxHeight - config.minHeight
    }
    
    @GestureState private var translation: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                DragIndicator()
                self.content
            }
            .frame(width: geometry.size.width, height: self.config.maxHeight, alignment: .top)
            .background(HomeBackgroundBlurView())
            .cornerRadius(config.cornerRadius, corners: [.topLeft, .topRight])
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    guard abs(value.translation.height) > config.snapDistance else {
                        return
                    }
                    withAnimation(.interactiveSpring()) {
                        isOpen = value.translation.height < 0
                    }
                }
            )
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    @State private static var isOpen = false

    static var previews: some View {
        GeometryReader() { geometry in
            HomeBottomSheetView(maxHeight: geometry.size.height * 0.8) {
                Color.green
            }
        }
    }
}
