import Foundation
import Combine
import SwiftSoup

class MetacriticNetworking {
    var htmlContentFetcher = HTMLContentFetcher()
    
    func fetchHTMLContent(urlString: String, completion: @escaping (Result<[UpcomingRelease], Error>) -> Void){
        htmlContentFetcher.fetchHTMLContent(urlString: urlString) { htmlContent in
             guard let html = htmlContent else {
                 return completion(.failure(URLError.Code.badURL as! any Error ))
             }
             let releaseData = self.parseUpcomingReleases(htmlContent: html)
             completion(.success(releaseData))
         }
    }
    
    func parseUpcomingReleases(htmlContent: String) -> [UpcomingRelease] {
        var upcomingReleases = [UpcomingRelease]()
        
        do {
            let document = try SwiftSoup.parse(htmlContent)
            
            let musicTable = try document.select("table.musicTable")
            
            var releaseDate = ""
            var releases = [String: String]()
            
            for row in try musicTable.select("tr") {
                if try row.hasClass("module") {
                    if !releases.isEmpty {
                        upcomingReleases.append(UpcomingRelease(releaseDate: releaseDate, releases: releases))
                        releases.removeAll()
                    }
                    releaseDate = try row.select("th").text()
                } else {
                    // Otherwise, this row contains an artist and album title
                    let artistName = try row.select("td.artistName a").text()
                    let albumTitle = try row.select("td.albumTitle").text()
                    releases[artistName] = albumTitle
                }
            }
            
            // Don't forget to add the last gathered releases if any
            if !releases.isEmpty {
                upcomingReleases.append(UpcomingRelease(releaseDate: releaseDate, releases: releases))
            }
            
        } catch {
            // Handle error
            print("An error occurred: \(error)")
        }
        
        return upcomingReleases
    }

}
