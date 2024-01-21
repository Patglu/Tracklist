import NeedleFoundation
import SwiftUI

final class RootComponent: BootstrapComponent {
    
    var homeDataManager: any HomeDataManagerProtocol {
        shared{ HomeDataManager.shared }
    }
    
    
    var rootViewModel: RootViewModel {
        return RootViewModel()
    }
    
    var rootView: some View {
        RooView(viewModel: rootViewModel, homeComponent: homeViewComponent)
    }
    
    var homeViewComponent: HomeComponent {
        HomeComponent(root: "tracklist", parent: self)
    }
}
