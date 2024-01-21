import SwiftUI

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @ObservedObject var viewModel: ViewModel
    let trackListsComponent : TrackScrollComponentProtocol
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(UIColor(hex: "#080806"))
                    .ignoresSafeArea()
                ScrollView{
                    Text("TrackList")
                        .foregroundStyle(.white)
                    trackListsComponent.weeklySinglesTrackListView
                    trackListsComponent.weeklyAlbumTrackListView
//                    TrackScrollView(tracks: viewModel.homeViewModel.homeDataManager,
//                                    header: "New Singles")
//                    TrackScrollView(viewModel: <#T##_#>)
                }
            }
            .navigationDestination(for: AlbumInfo.self) { album in
                AlbumDetailView(albumInfo: album)
            }
        }
    }
}

//#Preview {
//    HomeView(viewModel: HomeViewModel(homeDataManager: HomeDataManager.shared ), trackListsComponent: TrackViewComponent())
//}
