import Foundation

//should use a use case protocol
class UpcommingReleasesViewModel: ObservableObject {
    //pass all this to the front with needle
    @Published var upcommingReleasesRepository = UpcommingReleasesRepository(metacriticNetworking: MetacriticNetworking())
    @Published var upcommingReleases: [UpcomingRelease] = [UpcomingRelease]()
    
    init() {
        self.upcommingReleases = getUpcommingReleases()
    }
    
    func getUpcommingReleases() -> [UpcomingRelease] {
        return upcommingReleasesRepository.releases
    }
}
