import SwiftUI

struct HomeView: View {
    @StateObject var dataManager = DataManager.shared
    @State private var startIndex = 0
    var metacriticNetworking = MetacriticNetworking()
    var body: some View {
        NavigationStack{
            ZStack{
                Color(UIColor(hex: "#080806"))
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false){
                    NavigationLink(destination: UpcommingReleases()) {
                        upcommingReleasesView
                    }
                    ForEach(HomeViewCardFeature.allCases){ card in
                        HomeCard(tracks: dataManager.getHomeViewCardData(card: card), type: card)
                    }
//                    Text("More coming soon for this homeview")
//                        .padding(.vertical)
                }
                .navigationTitle("HQ")
                .padding(.horizontal)
            }
            .navigationDestination(for: AlbumInfo.self) { album in
                AlbumDetailView(albumInfo: album)
            }
            .navigationDestination(for: HomeViewCardFeature.self) { card in
                TrackScrollView(tracks: dataManager.getHomeViewCardData(card: card))
            }
        }
    }
    
    var upcommingReleasesView : some View {
        VStack(alignment: .leading){
            Text("Upcomming")
                .font(.system(size: 35))
                .bold()
            Text("Releases")
                .font(.title)
        }
        .foregroundStyle(.white)
        .padding(.leading)
        .frame(width: 350, height: 180, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(.grainGradient())
        )
    }
}

#Preview {
    HomeView()
}
