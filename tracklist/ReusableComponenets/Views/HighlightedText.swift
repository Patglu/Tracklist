
import SwiftUI

struct HighlightedText: View {
    var text: String = ""
    
    var body: some View {
        Text(text)
            .foregroundStyle(.black)
            .padding(10)
            .background(
                Rectangle()
                    .foregroundColor(.yellow)
            )
    }
}

#Preview {
    HighlightedText(text: "Albums")
}
