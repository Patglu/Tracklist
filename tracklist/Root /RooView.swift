import SwiftUI

struct RooView<ViewModel>: View where ViewModel: RootViewModel{
    var viewModel: ViewModel
    let homeComponent: HomeComponentProtocol
    
    var body: some View {
        NavigationStack{
            switch viewModel.feature {
            case .discover:
                homeComponent.homeView
            }
        }
    }
}

#Preview {
    let rootComponent = RootComponent()
    return RooView(viewModel: rootComponent.rootViewModel, homeComponent: rootComponent.homeViewComponent)
}
