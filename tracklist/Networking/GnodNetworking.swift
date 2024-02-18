import Foundation
import Combine
import SwiftSoup

class GnodNetworking {
    
    // Function to fetch and parse HTML content from a given URL and return a Combine publisher
    func fetchAndParseArtists(from urlString: String) -> AnyPublisher<[(name: String, url: String)], Error> {
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> String in
                // Ensure the response is valid and decode the data to String
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return String(data: output.data, encoding: .utf8) ?? ""
            }
            .tryMap { htmlContent -> [(name: String, url: String)] in
                // Parse the HTML content to extract artist names and URLs
                try self.parseHTML(htmlContent)
            }
            .receive(on: DispatchQueue.main) // Ensure the publisher sends events on the main thread
            .eraseToAnyPublisher() // Erase to AnyPublisher for a cleaner external interface
    }
    
    // Private function to parse HTML content for artist names and URLs
    private func parseHTML(_ html: String) throws -> [(name: String, url: String)] {
        let baseUrl = "https://www.music-map.com/"
        let document = try SwiftSoup.parse(html)
        
        // Attempt to select the div with the ID 'gnodMap'
        guard let gnodMapDiv = try document.select("div#gnodMap").first() else {
            // If the div isn't found, return an empty array
            return []
        }
        
        // Select all <a> tags within the gnodMapDiv
        let links = try gnodMapDiv.select("a")
        
        // Map each <a> element to a tuple of its text (name) and href attribute (url)
        return try links.array().compactMap { link in
            let name = try link.text()
            var url = try link.attr("href")
            
            // Check if the URL is relative. If so, prepend the base URL
            if !url.contains("http://") && !url.contains("https://") {
                url = baseUrl + url
            }
            
            return (name: name, url: url)
        }
    }
}
