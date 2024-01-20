import Foundation
import SwiftSoup

class NetworkManager {
    /*Fetcher should just do all the network requests
     Add a gate way to format to a different model
     from gateway we cache everything
     The view model gets everything from the repo
     The view talks to the viewmodel to get 
     */
    static let shared = NetworkManager()
    
    private let urlSession = URLSession.shared
    private let htmlContentFetcher: HTMLContentFetcherable
    private let apiRequestHandler: APIRequestHandlerable
    private let htmlParser: HTMLParserable
    
    private init(){
        self.htmlContentFetcher = HTMLContentFetcher()
        self.apiRequestHandler = APIRequestHandler()
        self.htmlParser =  HTMLParser()
    }
    
    

    func fetchTracks(start: Int, size: Int = 6, completion: @escaping (Result<TracksResponse, Error>) -> Void) {
        apiRequestHandler.fetchTracks(start: start, size: size) { result in
            switch result {
            case .success(let tracksResponse):
                completion(.success(tracksResponse))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }

    
    func fetchHTMLContent(urlString: String, completion: @escaping (String?) -> Void) {
        htmlContentFetcher.fetchHTMLContent(urlString: urlString) { htmlContent in
             guard let html = htmlContent else {
                 completion(nil)
                 return
             }
             let albumData = self.htmlParser.parseHTML(html: html)
             completion(htmlContent)
         }
    }
    
    func parseHTML(html: String) -> [AlbumInfo] {
        htmlParser.parseHTML(html: html)
    }
    

    func parseAlbumDetails(from html: String) -> AlbumDetail? {
        htmlParser.parseAlbumDetails(from: html)
    }


}
