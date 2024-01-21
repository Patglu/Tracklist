import SwiftUI

struct TrackScrollView<ViewModel>: View where ViewModel: TrackScrollViewModelProtocol {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.tracks) { trackItem in
                    NavigationLink(value: trackItem) {
                        VStack {
                            AsyncImage(url: URL(string: trackItem.imageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 200)
                            Text(trackItem.artistTitle)
                                .font(.callout)
                            Text(trackItem.albumTitle)
                                .font(.caption)
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
        .frame(height: 300)
        .overlay(alignment: .topLeading) {
            HighlightedText(text: viewModel.header)
        }
    }
}

#Preview {
    TrackScrollView(viewModel: TrackScrollViewModel(tracks: [], header: ""))
}
