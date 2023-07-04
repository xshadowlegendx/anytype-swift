import Foundation
import SwiftUI

struct LaunchView: View {
    
    var body: some View {
        ZStack {
            Color.Background.primary
            Image(asset: .splashLogoWhite)
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
    }
}

struct LaunchView_Previews: PreviewProvider {
    
    static var previews: some View {
        LaunchView()
    }
}
