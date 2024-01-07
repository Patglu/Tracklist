import Foundation

protocol HTMLContentFetcher {
    func fetchHTMLContent(urlString: String, completion: @escaping (String?) -> Void)
}

protocol APIRequestHandler {
    func fetchTracks(start: Int, size: Int, completion: @escaping (Result<TracksResponse, Error>) -> Void)
    // Define other API request methods here
}

protocol HTMLParser {
    func parseHTML(html: String) -> [AlbumInfo]
    func parseAlbumDetails(from html: String) -> AlbumDetail?
}
