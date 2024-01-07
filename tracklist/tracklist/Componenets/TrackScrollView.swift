import SwiftUI

struct TrackScrollView: View {
    var tracks: [AlbumInfo]
    var header: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(Array(tracks.enumerated()), id: \.element.imageUrl) { index, trackItem in
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
//                            .onAppear {
//                                if index == dataManager.getTitleArtistAndStandardSizes().count - 1 {
//                                    loadMoreTracks()
//                                }
//                            }
                }
            }
        }
        .frame(height: 300)
        .overlay(alignment: .topLeading) {
            HighlightedText(text: header)
        }
    }
}

#Preview {
    TrackScrollView(tracks: [AlbumInfo](), header: "New tracks")
}
