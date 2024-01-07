import Foundation

// Main response model
struct TracksResponse: Codable {
    var count: Int?
    var previous: String?
    var next: String?
    var results: Results?
}

// Results containing categories and lists
struct Results: Codable {
    var category: Category?
    var list: [TrackItem]?
}

// Category information
struct Category: Codable {
    var header: String?
    var id: String?
    var name: String?
    var bio: String?
    var mobile_header: String?
    var social_title: String?
    var social_description: String?
    var social_image: String?
    var url: String?
}

// Track item details
struct TrackItem: Codable {
    var dek: String?
    var seoDescription: String?
    var promoDescription: String?
    var socialDescription: String?
    var authors: [Author]?
    var id: String?
    var contentType: String?
    var privateTags: [String]?
    var tags: [String]?
    var pubDate: String?
    var timestamp: Int?
    var modifiedAt: String?
    var channel: String?
    var subChannel: String?
    var title: String?
    var seoTitle: String?
    var socialTitle: String?
    var promoTitle: String?
    var url: String?
    var photos: Photos?
    var tracks: [Track]?
    var artists: [Artist]?
    var bnm: Bool?
    var genres: [Genre]?
    var audiofiles: [String]?
    var audio_files: [String]?
}

// Author details
struct Author: Codable {
    var id: String?
    var name: String?
    var title: String?
    var url: String?
    var slug: String?
}

// Photo details
struct Photos: Codable {
    var tout: PhotoDetails?
    var lede: PhotoDetails?
    var social: PhotoDetails?
}

struct PhotoDetails: Codable {
    var width: Int?
    var height: Int?
    var credit: String?
    var caption: String?
    var altText: String?
    var modelName: String?
    var title: String?
    var sizes: PhotoSizes?
}

struct PhotoSizes: Codable {
    var list: String?
    var homepageSmall: String?
    var homepageLarge: String?
    var standard: String?
    var smallModule: String?
    var largeModule: String?
}

// Track details
struct Track: Codable {
    var display_name: String?
    var artists: [Artist]?
    var labels: [Label]?
    var release_year: Int?
}

struct Artist: Codable {
    var id: String?
    var name: String?
    var slug: String?
    var display_name: String?
    var description: String?
    var url: String?
    var similar: [String]?
    var genres: [Genre]?
    var imageCredit: String?
    var photos: Photos?
    var topStories: [String]?
}

// Label details
struct Label: Codable {
    var id: String?
    var name: String?
    var display_name: String?
}

// Genre details
struct Genre: Codable {
    var display_name: String?
    var slug: String?
}
