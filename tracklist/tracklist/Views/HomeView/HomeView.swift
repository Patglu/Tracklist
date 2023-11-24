import SwiftUI

struct HomeView: View {
    @StateObject var dataManager = DataManager.shared
    @State private var startIndex = 0
    
    var body: some View {
        ZStack{
            Color(UIColor(hex: "#080806"))
                .ignoresSafeArea()
            ScrollView{
                Text("Tracklist")
                    .foregroundStyle(.white)
                
                TrackScrollView(tracks: dataManager.weeklySingles.shuffled(), header: "New Singles")
                TrackScrollView(tracks: dataManager.weeklyAlbums.shuffled(), header: "New Albums")
                
            }
        }
    }
    
    private func loadMoreTracks() {
        startIndex += 6
        dataManager.fetchTracksData(start: startIndex) { success, error in
            if success {
                print("More tracks loaded.")
            } else if let error = error {
                print("Error loading more tracks: \(error)")
            }
        }
    }
}

#Preview {
    HomeView()
}
