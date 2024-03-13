import SwiftUI

enum HomeViewCardFeature: String, Hashable, CaseIterable, Identifiable {
    var id: String{
        self.rawValue
    }
    
    case singles = "Singles"
    case albums = "Albums"
}

struct HomeCard: View {
    var tracks: [AlbumInfo]
    var type: HomeViewCardFeature
    
    var body: some View {
        NavigationLink(value: type) {
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 5){
                    if type == .albums{
                        HStack(alignment: .top){
                            Text(type.rawValue)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                        
                            HStack(alignment: .bottom){
                                if tracks.indices.contains(1) {
                                    // Small single cover
                                    trackItemView(trackItem: tracks[1], width: 60, height: 60)
                                        .cornerRadius(8)
                                } else {
                                    Rectangle()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                }
                                if tracks.indices.contains(0) {
                                    trackItemView(trackItem: tracks[0], width: 120, height: 120)
                                        .cornerRadius(8)
                                }
                                
                                
                            }
                            
                        }
                    }else {
                        HStack(alignment: .top){
                            // Check if the indices exist before accessing them
                            HStack(alignment: .bottom){
                                if tracks.indices.contains(0) {
                                    trackItemView(trackItem: tracks[0], width: 120, height: 120)
                                        .cornerRadius(8)
                                }
                                
                                if tracks.indices.contains(1) {
                                    // Small single cover
                                    trackItemView(trackItem: tracks[1], width: 60, height: 60)
                                        .cornerRadius(8)
                                }
                            }
                            Text(type.rawValue)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                        }
                    }
                    HStack(spacing: 5 ){
                        if tracks.indices.contains(2) {
                            trackItemView(trackItem: tracks[2], width: 60, height: 60)
                                .cornerRadius(8)
                        }
                        if tracks.indices.contains(3) {
                            trackItemView(trackItem: tracks[3], width: 120, height: 60)
                                .cornerRadius(8)
                        }
                        if tracks.indices.contains(4) {
                            trackItemView(trackItem: tracks[4], width: 60, height: 60)
                                .cornerRadius(8)
                        }
                        if tracks.indices.contains(5) {
                            trackItemView(trackItem: tracks[5], width: 60, height: 60)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.black)
                    .opacity(0.1)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.black, Color.white.opacity(0.2)]), startPoint: .bottom,
                                                            endPoint: .top))
                    }
                    
            }
        }
    }
    func trackItemView(trackItem: AlbumInfo, width:CGFloat =  60, height:CGFloat = 60 ) -> some View {
        AsyncImage(url: URL(string: trackItem.imageUrl)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
        } placeholder: {
            ProgressView()
                .frame(width: width, height: height)
        }
        .cornerRadius(8.0)
        .foregroundStyle(.white)
    }
}


#Preview {
    HomeCard(tracks: AlbumInfo.repeatedElements, type: .albums)
}


