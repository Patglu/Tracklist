import RealmSwift
import SwiftUI

struct AlbumInfo : Identifiable, Hashable{
    var id: UUID = UUID()
    var artistTitle: String
    var artistUrl: String?
    var albumTitle: String
    var albumUrl: String?
    var imageUrl: String
}


class DBAlbumInfo : Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var artistTitle = ""
    @Persisted var albumTitle = ""
    @Persisted var albumUrl = ""
    @Persisted var dateSaved = Date()
}



extension AlbumInfo {
    static var firstElement: AlbumInfo = {
        AlbumInfo(
            id: UUID(),
            artistTitle: "Real Estate",
            artistUrl:  "/artist/683-real-estate/",
            albumTitle: "Daniel",
            albumUrl:  "/album/806296-real-estate-daniel.php",
            imageUrl: "https://i.scdn.co/image/ab67616d0000b27312c80c8035af957851767fd1"
        )
    }()
    
    static var repeatedElements: [AlbumInfo] = Array(repeating: AlbumInfo.firstElement, count: 12) 
}
