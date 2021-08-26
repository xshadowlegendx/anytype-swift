import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var title: String
    
    var body: some View {
        VStack(spacing: 10) {
            TextField(title, text: $text)
            Divider()
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        return CustomTextField(text: .constant(""), title: "Enter your name")
    }
}
