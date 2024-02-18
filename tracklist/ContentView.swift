

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
