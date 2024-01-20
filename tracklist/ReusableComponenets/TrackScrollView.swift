import SwiftUI

struct TrackScrollView: View {
    var tracks: [AlbumInfo]
    var header: String
    
    @State private var albumDetail = AlbumDetail(title: "" , artist: "", releaseYear: "", genre: [], coverImageUrl: "", criticScore: 0, userScore: 0, trackList: [])
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(tracks) { trackItem in
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
            HighlightedText(text: header)
        }
    }
}

#Preview {
    TrackScrollView(tracks: [AlbumInfo](), header: "New tracks")
}
