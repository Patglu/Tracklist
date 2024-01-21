import Foundation


class AlbumRepository {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchAlbums(completion: @escaping ([AlbumInfo]?) -> Void) {
        // Use NetworkManager to fetch and parse albums
    }
    
    func getAlbumDetails(albumID: String) -> AlbumDetail{
        let baseURL = "https://www.albumoftheyear.org"
        let albumDetailURL = URL(string:"\(baseURL)\(albumID)")!
        var albumDetail = AlbumDetail(title: "", artist: "", releaseYear: "", genre: [], coverImageUrl: "", criticScore: 0, userScore: 0, trackList: [])
        networkManager.fetchHTMLContent(urlString: albumDetailURL.absoluteString) { htmlContent in
            if let html = htmlContent {
                DispatchQueue.main.async {
                    albumDetail = self.networkManager.parseAlbumDetails(from: html) ?? .example
                }
            }
        }
        return albumDetail
    }
    


}

class AlbumService {
    private let albumRepository: AlbumRepository

    init(albumRepository: AlbumRepository) {
        self.albumRepository = albumRepository
    }

    func getAlbumsWithDetails(completion: @escaping ([AlbumDetail]?) -> Void) {
        // Combine data from multiple sources and return
    }

    // Add more service methods as needed
}
