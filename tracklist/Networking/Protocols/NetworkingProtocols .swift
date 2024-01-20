import Foundation

protocol HTMLContentFetcherable {
    func fetchHTMLContent(urlString: String, completion: @escaping (String?) -> Void)
}

protocol APIRequestHandlerable {
    func fetchTracks(start: Int, size: Int, completion: @escaping (Result<TracksResponse, Error>) -> Void)
}

protocol HTMLParserable {
    func parseHTML(html: String) -> [AlbumInfo]
    func parseAlbumDetails(from html: String) -> AlbumDetail?
}
