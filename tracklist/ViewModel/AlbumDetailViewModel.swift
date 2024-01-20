import Foundation

class AlbumDetailViewModel: ObservableObject{
    private let networkManager = NetworkManager.shared
    @Published var albumDetail: AlbumDetail?
    
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
}
