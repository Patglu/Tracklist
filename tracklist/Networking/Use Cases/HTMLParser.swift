import Foundation
import SwiftSoup

class DefaultHTMLParser: HTMLParser {
    
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
