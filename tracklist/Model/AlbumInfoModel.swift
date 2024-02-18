import Foundation

struct AlbumInfo : Identifiable, Hashable{
    var id: UUID = UUID()
    var artistTitle: String
    var artistUrl: String?
    var albumTitle: String
    var albumUrl: String?
    var imageUrl: String
}

extension AlbumInfo {
    static var firstElement: AlbumInfo = {
        AlbumInfo(
            id: UUID(),
            artistTitle: "Kerli",
            artistUrl:  "/artist/1698-kerli/",
            albumTitle: "The Witching Hour",
            albumUrl:  "/album/877232-kerli-the-witching-hour.php",
            imageUrl: "https://cdn2.albumoftheyear.org/400x/album/877232-the-witching-hour_232633.jpg"
        )
    }()
    
    static var repeatedElements: [AlbumInfo] = Array(repeating: AlbumInfo.firstElement, count: 5) 
}
