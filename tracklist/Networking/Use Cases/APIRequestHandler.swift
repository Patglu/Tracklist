import Foundation
import SwiftSoup

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class DefaultAPIRequestHandler: APIRequestHandler {
    private let urlSession = URLSession.shared
    private let baseUrl = "https://pitchfork.com/api/v2/search/"
    private let albumOfTheYearUrl = "https://www.albumoftheyear.org/releases/this-week/singles/"
    
    
    func fetchTracks(start: Int, size: Int, completion: @escaping (Result<TracksResponse, Error>) -> Void) {
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
    
}
