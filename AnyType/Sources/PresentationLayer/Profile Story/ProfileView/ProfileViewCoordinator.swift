import SwiftUI

final class ProfileViewCoordinator {
    private let profileService: ProfileService = .init()
    private let authService: AuthService = .init()
    lazy private(set) var viewModel = ProfileViewModel(
        profileService: self.profileService,
        authService: self.authService
    )
    
    var profileView: some View {
        ProfileView(model: self.viewModel)
    }
}
