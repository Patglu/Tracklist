import Foundation

protocol TrackScrollViewModelProtocol : ObservableObject{
    var tracks: [AlbumInfo] { get set }
    var header: String { get set }
}

final class TrackScrollViewModel: TrackScrollViewModelProtocol {
    @Published var tracks: [AlbumInfo] = []
    var header: String = ""
    
    init(tracks: [AlbumInfo], header: String) {
        self.tracks = tracks
        self.header = header
    }
    
}
