import Foundation


protocol AlbumDetailable: Identifiable, Hashable, Equatable{
    var title: String {get set}
    var artist: String {get set}
    var releaseYear: String {get set}
    var genre: [String] {get set}
    var coverImageUrl: String {get set}
    var criticScore: Int {get set}
    var userScore: Int {get set}
    var trackList: [Single] {get set}
}

//MARK: For decoding then have one to use for in app use 
struct AlbumDetail: Codable, AlbumDetailable {
    static func == (lhs: AlbumDetail, rhs: AlbumDetail) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var title: String
    var artist: String
    var releaseYear: String
    var genre: [String]
    var coverImageUrl: String
    var criticScore: Int
    var userScore: Int
    var trackList: [Single]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(id: UUID = UUID(), title: String, artist: String, releaseYear: String, genre: [String], coverImageUrl: String, criticScore: Int, userScore: Int, trackList: [Single]) {
        self.id = id
        self.title = title
        self.artist = artist
        self.releaseYear = releaseYear
        self.genre = genre
        self.coverImageUrl = coverImageUrl
        self.criticScore = criticScore
        self.userScore = userScore
        self.trackList = trackList
    }
    
}

struct Single: Codable {
    let number: Int
    let title: String
    let length: String
    let rating: Int
}

extension AlbumDetail{
    static let example = AlbumDetail(
        title: "Quaranta",
        artist: "Danny Brown",
        releaseYear: "2023",
        genre: ["conscious hip hop", "hip hop", "experimental hip hop", "hardcore hip hop", "alternative hip hop"],
        coverImageUrl: "https://cdn2.albumoftheyear.org/375x/album/2023/738402-quaranta-2.jpg",
        criticScore: 79,
        userScore: 84,
        trackList: [
            Single(number: 1, title: "Quaranta", length: "2:39", rating: 90),
            Single(number: 2, title: "Tantor", length: "2:28", rating: 88),
            Single(number: 3, title: "Ain't My Concern", length: "2:50", rating: 85),
            Single(number: 4, title: "Dark Sword Angel", length: "2:40", rating: 86),
            Single(number: 5, title: "Y.B.P.", length: "2:56", rating: 83), // Add 'feat. Bruiser Wolf' as needed
            Single(number: 6, title: "Jenn’s Terrific Vacation", length: "3:26", rating: 91), // Add 'feat. Kassa Overall' as needed
            Single(number: 7, title: "Down Wit It", length: "2:40", rating: 89),
            Single(number: 8, title: "Celibate", length: "3:58", rating: 86), // Add 'feat. MIKE' as needed
            Single(number: 9, title: "Shakedown", length: "3:28", rating: 83),
            Single(number: 10, title: "Hanami", length: "3:27", rating: 88),
            Single(number: 11, title: "Bass Jam", length: "3:43", rating: 86)
        ]
    )
}
