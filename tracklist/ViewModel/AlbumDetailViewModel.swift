import Foundation
import Combine

class AlbumDetailViewModel: ObservableObject{
    private let networkManager = NetworkManager.shared
    private let networking = GnodNetworking()
    private var cancellables = Set<AnyCancellable>()
     
    @Published var similarArtists: [(name: String, url: String)] = []
    @Published var albumDetail: AlbumDetail?{
        didSet{
            if let artist = albumDetail?.artist {
                self.loadArtists(for: artist)
            }
        }
    }
    
    
    init(albumDetail: AlbumDetail? = nil) {
        self.albumDetail = albumDetail
    }
    /*
     Turn the albuminfo into albumdetail
     */
    func getAlbumDetails(albumID: String){
        let baseURL = "https://www.albumoftheyear.org"
        let albumDetailURL = URL(string:"\(baseURL)\(albumID)")!
        networkManager.fetchHTMLContent(urlString: albumDetailURL.absoluteString) { htmlContent in
            if let html = htmlContent {
                DispatchQueue.main.async {
                    self.albumDetail = self.networkManager.parseAlbumDetails(from: html)
                }
            }
        }
    }
    
    /*
     get similar artists
     */
    private func loadArtists(for artist: String) {
        // Encode the artist name to safely include it in a URL
        guard let encodedArtistName = artist.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            print("Failed to encode artist name")
            return
        }
        
        let urlString = "https://www.music-map.com/\(encodedArtistName)"
        
        networking.fetchAndParseArtists(from: urlString)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] artists in
                self?.similarArtists = Array(artists.dropFirst())
            })
            .store(in: &cancellables)
    }
}
