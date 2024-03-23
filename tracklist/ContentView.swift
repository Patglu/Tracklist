

import SwiftUI

struct ContentView: View {
    var body: some View {
//        CDView()
        TabView{
            HomeView()
                .tabItem { Image(systemName: "globe") }
                
            FavouritesView()
                .tabItem { Image(systemName: "globe") }
        }
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
