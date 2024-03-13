
import Foundation

struct UpcomingRelease: Identifiable, Hashable {
    var id = UUID()
    var releaseDate: String
    var releases: [String : String]
}
