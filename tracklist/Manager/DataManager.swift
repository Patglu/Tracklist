import Foundation
    /*
     Add protocols
     Use uses cases that follow the clean architecture
     */
class DataManager: ObservableObject {
    static let shared = DataManager()
    private let networkManager = NetworkManager(htmlContentFetcher: HTMLContentFetcher(), apiRequestHandler: APIRequestHandler(), htmlParser: HTMLParser())
    @Published var tracksResponse: TracksResponse?
    @Published var weeklySingles = [AlbumInfo]()
    @Published var weeklyAlbums = [AlbumInfo]()
    @Published var albumDetail: AlbumDetail?
    
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
    }
    
    func fetchTracksData(start: Int, completion: @escaping (Bool, Error?) -> Void) {
        networkManager.fetchTracks(start: start) { result in
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
    
    func getHomeViewCardData(card: HomeViewCardFeature) -> [AlbumInfo] {
        switch card {
        case .singles:
            return self.weeklySingles
        case .albums:
            return self.weeklyAlbums
        }
    }
    
    func getWeeklySinglesData(){
        let weeklhySingles = "https://www.albumoftheyear.org/releases/this-week/singles/"
        networkManager.fetchHTMLContent(urlString: weeklhySingles) { htmlContent in
            DispatchQueue.main.async {
                if let html = htmlContent {
                    self.weeklySingles = self.networkManager.parseHTML(html: html)
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
