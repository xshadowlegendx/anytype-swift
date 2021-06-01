import SwiftUI

struct HomeProfileView: View {
    @EnvironmentObject var accountData: AccountInfoDataAccessor
    @EnvironmentObject var model: HomeViewModel
    
    private let topPaddingRatio: CGFloat = 0.16
    private let buttonsPaddingRatio: CGFloat = 0.05
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                VStack {
                    hiText(containerHeight: geometry.size.height)
                    avatar
                    buttons.padding(.top, geometry.size.height * buttonsPaddingRatio)
                }.frame(maxHeight: geometry.size.height / 2 - 30) // less then bottom sheet
                Spacer()
                slogan(containerHeight: geometry.size.height)
            }.frame(width: geometry.size.width, height: geometry.size.height)
            .animation(.default, value: accountData.blockId)
        }
    }
    
    func hiText(containerHeight: CGFloat) -> some View {
        AnytypeText("Hi, \(accountData.name ?? "")", style: .title)
            .foregroundColor(.white)
            .padding(.top, containerHeight * topPaddingRatio)
            .padding(.bottom, 15)
            .transition(.opacity)
    }
    
    private var avatar: some View {
        Group {
            if let blockId = accountData.blockId {
                NavigationLink(
                    destination: model.coordinator.documentView(selectedDocumentId: blockId),
                    label: { userIcon }
                )
            } else {
                userIcon
            }
        }
    }
    
    private var userIcon: some View {
        return UserIconView(
            image: accountData.avatarId.flatMap { .middleware(imageId: $0) },
            name: accountData.name
        )
        .frame(width: 80, height: 80)
    }
    
    private var buttons: some View {
        HStack(spacing: 10) {
            Button(action: {}) {
                HomeProfileViewButtonImage(
                    image: Image.main.search.renderingMode(.template).foregroundColor(Color.gray.opacity(0.4))
                )
            }.disabled(true)
            Button(action: {}) {
                HomeProfileViewButtonImage(
                    image: Image.main.marketplace.renderingMode(.template).foregroundColor(Color.gray.opacity(0.4))
                )
            }.disabled(true)
            Button(action: model.createNewPage) {
                HomeProfileViewButtonImage(image: Image.main.draft)
            }
        }
    }
    
    private func slogan(containerHeight: CGFloat) -> some View {
        AnytypeText("The future will be the one you build", style: .title)
            .padding(.bottom, containerHeight / 7)
            .padding()
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct HomeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileView()
    }
}
