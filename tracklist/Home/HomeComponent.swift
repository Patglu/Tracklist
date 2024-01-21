import SwiftUI
import NeedleFoundation

protocol HomeComponentProtocol {
    var homeView: AnyView { get }
}

final class HomeComponent: Component<EmptyDependency>, HomeComponentProtocol {
    let root: String
//    var homeDataManager: any HomeDataManagerProtocol {
//        shared{ HomeDataManager.shared }
//    }
    init(root: String, parent: Scope) {
        self.root = root
        super.init(parent: parent)
    }
    
    var homeViewModel: HomeViewModel {
        return HomeViewModel(root: root)
    }
    
    var homeView: AnyView {
        AnyView(
            HomeView(viewModel: homeViewModel, trackListsComponent: trackScrollComponent)
        )
    }
    
    var trackScrollComponent: TrackScrollComponent {
        TrackScrollComponent(parent: self)
    }
    
}
