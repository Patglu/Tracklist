import Foundation
// store the data here once it's called so the view model just has to retrieve it

class UpcommingReleasesRepository: ObservableObject {
    @Published var releases: [UpcomingRelease] = [UpcomingRelease]()
    private let metacriticNetworking : MetacriticNetworking
    private let upcommingReleasesURL = "https://www.metacritic.com/browse/albums/release-date/coming-soon/date"
    
    init(metacriticNetworking: MetacriticNetworking) {
        self.metacriticNetworking = metacriticNetworking
        fetchReleases()
    }
    
    func fetchReleases(){
        metacriticNetworking.fetchHTMLContent(urlString: upcommingReleasesURL) { result  in
            switch result {
            case .success(let success):
                self.releases = success
            case .failure(let failure):
                debugPrint(failure)
            }
        }
    }
}
