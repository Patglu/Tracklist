

import SwiftUI

struct ContentView: View {
    var body: some View {
//        CDView()
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
