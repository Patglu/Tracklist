import SwiftUI
import NeedleFoundation

protocol TrackScrollComponentProtocol {
    var weeklyAlbumTrackListView: AnyView { get }
    var weeklySinglesTrackListView: AnyView { get }
}

//protocol TrackListDependency: Dependency {
//    var trackDataProvider: any HomeDataManagerProtocol { get }
//}

final class TrackScrollComponent: Component<EmptyDependency>, TrackScrollComponentProtocol {
    
    var homeDataManager: HomeDataManager {
        return HomeDataManager.shared
    }
        
    var weeklyAlbumScrollViewModel: TrackScrollViewModel {
        return TrackScrollViewModel(tracks: homeDataManager.weeklyAlbums, header: "Albums")
    }
    
    var weeklySinglesScrollViewModel: TrackScrollViewModel {
        return TrackScrollViewModel(tracks: homeDataManager.weeklySingles, header: "Singles")
    }

    
    var weeklyAlbumTrackListView: AnyView{
        AnyView(
        TrackScrollView(viewModel: weeklyAlbumScrollViewModel)
        )
    }
    
    var weeklySinglesTrackListView: AnyView{
        AnyView(
            TrackScrollView(viewModel: weeklySinglesScrollViewModel)
        )
    }
    

    
    
    
}
