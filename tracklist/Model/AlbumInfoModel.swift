import Foundation

struct AlbumInfo : Identifiable, Hashable{
    var id: UUID = UUID()
    var artistTitle: String
    var artistUrl: String?
    var albumTitle: String
    var albumUrl: String?
    var imageUrl: String
}
