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

    private let baseUrl = "https://pitchfork.com/api/v2/search/"
    private let albumOfTheYearUrl = "https://www.albumoftheyear.org/releases/this-week/singles/"
    
    private let urlSession = URLSession.shared

    private init(){
        fetchHTMLContent(urlString: albumOfTheYearUrl) { htmlContent in
            if let html = htmlContent {
                let albumData = self.parseHTML(html: html)
                
            }
        }
    }

    func fetchTracks(start: Int, size: Int = 6, completion: @escaping (Result<TracksResponse, Error>) -> Void) {
        let queryItems = [
            URLQueryItem(name: "types", value: "reviews"),
            URLQueryItem(name: "hierarchy", value: "sections/reviews/tracks,channels/reviews/tracks"),
            URLQueryItem(name: "sort", value: "publishdate desc"),
            URLQueryItem(name: "isbestnewmusic", value: "true"),
            URLQueryItem(name: "size", value: "\(size)"),
            URLQueryItem(name: "start", value: "\(start)")
        ]

        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }

        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.noData))
                return
            }

            do {
                let tracksResponse = try JSONDecoder().decode(TracksResponse.self, from: data)
                
                completion(.success(tracksResponse))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }

        task.resume()
    }

    enum NetworkError: Error {
        case invalidUrl
        case noData
        case decodingError
    }
    
    func fetchHTMLContent(urlString: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let htmlContent = String(data: data, encoding: .utf8)
            completion(htmlContent)
        }
        task.resume()
    }
    
    func parseHTML(html: String) -> [AlbumInfo] {
        var albums = [AlbumInfo]()

        do {
            let doc = try SwiftSoup.parse(html)
            let albumBlocks = try doc.select("div.albumBlock")

            for block in albumBlocks {
                // Artist details
                let artistLinkElement = try block.select("a").first(where: { try $0.select("div.artistTitle").size() > 0 })
                let artistTitle = try artistLinkElement?.select("div.artistTitle").text() ?? ""
                let artistUrl = try artistLinkElement?.attr("href") ?? ""

                // Album details
                let albumLinkElement = try block.select("a").first(where: { try $0.select("div.albumTitle").size() > 0 })
                let albumTitle = try albumLinkElement?.select("div.albumTitle").text() ?? ""
                let albumUrl = try albumLinkElement?.attr("href") ?? ""

                let imageElement = try block.select("img").first()
                let imageUrl = try imageElement?.attr("data-srcset") ?? ""
                // Split the string and take the first URL
                let imageUrlString = imageUrl.components(separatedBy: " ").first ?? ""
                
                let albumInfo = AlbumInfo(artistTitle: artistTitle, artistUrl: artistUrl, albumTitle: albumTitle, albumUrl: albumUrl, imageUrl: imageUrlString)
                albums.append(albumInfo)
            }
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }

        return albums
    }
    

    func parseAlbumDetails(from html: String) -> AlbumDetail? {
        do {
            let document = try SwiftSoup.parse(html)
            
            // Extracting album details
            let artist = try document.select("div.albumHeadline div.artist span[itemprop=name]").text()
            let title = try document.select("div.albumHeadline div.albumTitle span[itemprop=name]").text()
            let releaseYear = "2023"  // Extract the year from the relevant HTML part

            // Extracting genres
              let genreElements = try document.select("a[href^=/tag]").array()
              let genres = genreElements.compactMap { try? $0.text() }

            
            let coverImageUrl = try document.select("div.albumTopBox.cover img").attr("src")
            let criticScore = Int(try document.select("div.albumCriticScore").text()) ?? 0
            let userScore = Int(try document.select("div.albumUserScore").text()) ?? 0
            
            // Extracting track list
            let tracks = try document.select("table.trackListTable tr").array().compactMap { element -> Single? in
                guard let number = try? Int(element.select("td.trackNumber").text()),
                      let title = try? element.select("td.trackTitle").text(),
                      let length = try? element.select("div.length").text(),
                      let rating = try? Int(element.select("td.trackRating span").text()) else {
                    return nil
                }
                return Single(number: number, title: title, length: length, rating: rating)
            }

            return AlbumDetail(title: title, artist: artist, releaseYear: releaseYear, genre: genres, coverImageUrl: coverImageUrl, criticScore: criticScore, userScore: userScore, trackList: tracks)
        } catch Exception.Error(_, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }


}
