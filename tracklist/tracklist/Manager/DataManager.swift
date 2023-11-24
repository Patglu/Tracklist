import Foundation
    /*
     Add protocols
     Use uses cases that follow the clean architecture
     */
class DataManager: ObservableObject {
    static let shared = DataManager()
    private let networkManager = NetworkManager.shared
    
    @Published var tracksResponse: TracksResponse?
    @Published var weeklySingles = [AlbumInfo]()
    @Published var weeklyAlbums = [AlbumInfo]()
    
    
    private init() {
        fetchTracksData(start: 0) { success, error in
            if success {
                print("DataManager initialized with data.")
            } else if let error = error {
                print("Error initializing DataManager: \(error)")
            }
        }
        getWeeklySinglesData()
        getWeeklyAlbumsData()
        getAlbumDetails(albumID: "738402-danny-brown-quaranta.php")
    }
    
    func fetchTracksData(start: Int, completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.fetchTracks(start: start) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newResponse):
                    if self.tracksResponse == nil {
                        self.tracksResponse = newResponse // First time load
                    } else {
                        // Append new tracks to existing list
                        self.tracksResponse?.results?.list?.append(contentsOf: newResponse.results?.list ?? [])
                    }
                    completion(true, nil)
                case .failure(let error):
                    print("Error fetching tracks: \(error)")
                    completion(false, error)
                }
            }
        }
    }
    
    func getWeeklySinglesData(){
        let weeklhySingles = "https://www.albumoftheyear.org/releases/this-week/singles/"
        NetworkManager.shared.fetchHTMLContent(urlString: weeklhySingles) { htmlContent in
            DispatchQueue.main.async {
                if let html = htmlContent {
                    self.weeklySingles = NetworkManager.shared.parseHTML(html: html)
                    // Use albumData as needed in your app
                }
            }
        }
    }
    
    func getWeeklyAlbumsData(){
        let weeklyAlbums = "https://www.albumoftheyear.org/releases/this-week/"
            networkManager.fetchHTMLContent(urlString: weeklyAlbums) { htmlContent in
            DispatchQueue.main.async {
                if let html = htmlContent{
                    self.weeklyAlbums = self.networkManager.parseHTML(html: html)
                    
                }
            }
        }
    }
    
    func getTrackItem(at index: Int) -> TrackItem? {
        return tracksResponse?.results?.list?[index]
    }
    
    func getAlbumDetails(albumID: String){
        let baseURL = "https://www.albumoftheyear.org/album/"
        let albumDetailURL = URL(string:"\(baseURL)\(albumID)")!
        
        let albumDetail = "https://www.albumoftheyear.org/album/738402-danny-brown-quaranta.php"
        
        networkManager.fetchHTMLContent(urlString: albumDetail) { htmlContent in
            if let html = htmlContent {
                let albumData = self.networkManager.parseAlbumDetails(from: html)

            }
        }
        
    }
}

extension DataManager {
    /*use case*/
    func getTitleArtistAndStandardSizes() -> [(title: String, artistName: String, standardSizeURL: String)] {
        guard let trackItems = tracksResponse?.results?.list else {
            return []
        }
        
        return trackItems.compactMap { trackItem in
            guard let titleWithQuotes = trackItem.title,
                  let artistName = trackItem.artists?.first?.name,
                  let standardSizeURL = trackItem.photos?.lede?.sizes?.standard else {
                return nil
            }
            
            let title = titleWithQuotes.replacingOccurrences(of: "\"", with: "")
            
            return (title, artistName, standardSizeURL)
        }
    }
}
