
import Foundation

protocol RootViewModelProtocol: ObservableObject {
    var feature: Feature { get }
}

final class RootViewModel: RootViewModelProtocol {
    @Published var feature: Feature = .discover

    init() {
        updateFeature()
    }

    func updateFeature() {
        // functionality for switchig to a new tab 
    }
}

enum Feature {
    case discover
}
