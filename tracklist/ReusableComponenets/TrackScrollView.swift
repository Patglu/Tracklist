import SwiftUI

struct TrackScrollView: View {
    var tracks: [AlbumInfo]
    var header: String
    @State private var displayGrid = false // State to toggle between horizontal scroll and grid
    private var splitTracks: ([AlbumInfo], [AlbumInfo]) {
        let half = tracks.count / 2
        let evenTracks = Array(tracks.prefix(half))
        let oddTracks = Array(tracks.suffix(from: half))
        return (evenTracks, oddTracks)
    }
    var body: some View {
        Group {
            if !displayGrid {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(tracks.indices, id: \.self) { index in
                            trackItemView(trackItem: tracks[index])
                                .onAppear {
                                    // Check if the current item's index is the trigger point to switch the layout
                                    if index >= 6 {
                                        withAnimation {
                                            displayGrid = true
                                        }
                                        
                                    }
                                }
                        }
                    }
                }
                .frame(height: 300)
            } else {
                //                ScrollView(.vertical, showsIndicators: false) {
                ScrollView {
                    VStack {
                        Text(header)
                            .font(.headline)
                            .padding()
                        
                        HStack(alignment: .top) {
                            VStack{
                                ForEach(splitTracks.0) { track in
                                    trackItemView(trackItem: track)
                                }
                            }
                            VStack{
                                ForEach(splitTracks.1) { track in
                                    trackItemView(trackItem: track)
                                }
                            }
                        }
                    }
                }
                //                .frame(maxHeight: .infinity)
            }
        }
        .padding(.horizontal)
        .overlay(alignment: .topLeading) {
            HStack{
                HighlightedText(text: header) // Assuming HighlightedText is a custom View you have defined
                Button{
                    withAnimation {
                        displayGrid.toggle()
                    }
                } label: {
                    Text("Hide")
                }
            }
        }
        .animation(.easeInOut, value: displayGrid)
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
                AsyncImage(url: URL(string: trackItem.imageUrl)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 180, height: 250)
                .cornerRadius(8.0)
                .overlay(alignment: .bottom){
                    VStack(alignment: .leading){
                        Text(trackItem.artistTitle)
                            .font(.headline)
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
        TrackScrollView(tracks: AlbumInfo.repeatedElements, header: "New tracks")
            .padding()
    }
}
