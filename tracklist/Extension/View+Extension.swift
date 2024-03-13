import SwiftUI

struct DarkModePreview: ViewModifier {
    func body(content: Content) -> some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            content
        }
    }
}

extension View{
    func darkModePreview () -> some View {
        modifier(DarkModePreview())
    }
}

