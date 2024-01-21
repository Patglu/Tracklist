import Foundation
import NeedleFoundation

protocol HomeViewModelProtocol: ObservableObject {
    func getWeeklyTracks() -> [AlbumInfo]
    func getNewAlbums() -> [AlbumInfo]
}


final class HomeViewModel: HomeViewModelProtocol {
//    let dependency: TrackListDependency
//    
//    init(dependency: TrackListDependency) {
//        self.dependency = dependency
//    }
    let root: String
    
    init(root: String) {
        self.root = root
    }
    
    var homeDataManager: HomeDataManager = HomeDataManager.shared
    
    func getWeeklyTracks() -> [AlbumInfo] {
        homeDataManager.weeklySingles
    }
    
    func getNewAlbums() -> [AlbumInfo] {
        homeDataManager.weeklySingles
    }
}
