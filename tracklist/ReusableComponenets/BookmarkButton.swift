import SwiftUI

struct BookmarkButton: View {
    @State var buttonPresses: Bool = false
    var action: () -> Void

    var body: some View {
        Button {
            withAnimation(.spring()){
                buttonPresses.toggle()
                action()
            }
        } label: {
            Image(systemName: buttonPresses ? "bookmark.circle.fill" : "bookmark")
                .font(.title)
                .scaleEffect(buttonPresses ? 1 : 0.8)
                .animation(.interpolatingSpring(mass: 0.2, stiffness: 450, damping: 5, initialVelocity: 10),value: buttonPresses)
                .foregroundStyle(.white)
                .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: buttonPresses)
        }
    }
}

#Preview {
    BookmarkButton(){}
}
