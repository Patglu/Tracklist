
import SwiftUI

struct PlaceholderModifier: ViewModifier {
    var showPlaceholder: Bool
    var width: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        if showPlaceholder {
            Rectangle()
                .fill(Color.gray)
                .frame(width: width, height: height)
                .cornerRadius(8)
        } else {
            content
        }
    }
}

extension View {
    func placeholder(when showPlaceholder: Bool, width: CGFloat = 60 , height: CGFloat = 60) -> some View {
        self.modifier(PlaceholderModifier(showPlaceholder: showPlaceholder,width: width, height: height))
    }
}
