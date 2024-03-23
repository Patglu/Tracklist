import SwiftUI
import Kingfisher

struct TrackScrollView: View {
    var tracks: [AlbumInfo]
    var title: String
    private var splitTracks: ([AlbumInfo], [AlbumInfo]) {
        let half = tracks.count / 2
        let evenTracks = Array(tracks.prefix(half))
        let oddTracks = Array(tracks.suffix(from: half))
        return (evenTracks, oddTracks)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                HStack(alignment: .top) {
                    VStack(spacing: 80){
                        ForEach(splitTracks.0) { track in
                            trackItemView(trackItem: track)
                                .padding(4)
                        }
                    }
                    VStack(spacing: 40){
                        ForEach(splitTracks.1) { track in
                            trackItemView(trackItem: track)
                                .padding(4)
                        }
                    }
                }
                .padding(.top, 45)
            }
        }
        .frame(maxHeight: .infinity)
        .darkModePreview()
        .navigationTitle(title)
        
    }
    
    @ViewBuilder
    var trackItemsView: some View {
        ForEach(tracks) { trackItem in
            NavigationLink(value: trackItem) {
                trackItemView(trackItem: trackItem)
            }
        }
    }
    
    func trackItemView(trackItem: AlbumInfo) -> some View {
        NavigationLink(value: trackItem) {
            VStack {
                KFImage.url(URL(string: trackItem.imageUrl))
                    .resizable()
                    .fade(duration: 0.25)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 200)
                    .cornerRadius(8.0)
                    .overlay(alignment: .bottom){
                        VStack(alignment: .leading){
                            Text(trackItem.artistTitle)
                                .font(.headline)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Text(trackItem.albumTitle)
                                .font(.caption)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        .padding([.bottom,.top,.leading])
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .background(.ultraThinMaterial,
                                    in: RoundedRectangle(cornerRadius: 8,style: .continuous))
                        .cornerRadius(8)
                    }
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ZStack{
        Color.black
            .ignoresSafeArea()
        TrackScrollView(tracks: AlbumInfo.repeatedElements, title: "Singles")
        //            .padding()
    }
}
