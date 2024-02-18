import SwiftUI

struct AlbumDetailView: View {
    let albumInfo: AlbumInfo
    @StateObject var viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                AsyncImage(url: URL(string: viewModel.albumDetail?.coverImageUrl ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 550)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .overlay(alignment: .bottom){
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text(viewModel.albumDetail?.artist ?? "")
                                .font(.headline)
                            Text(viewModel.albumDetail?.title ?? "")
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        Text(viewModel.albumDetail?.releaseYear ?? "")
                            
                    }
                    .font(.callout)
                    .padding()
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .background(.ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8,style: .continuous))
                    .cornerRadius(8)
                }
                .overlay(alignment: .bottom) {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(viewModel.albumDetail?.genre ?? [], id: \.self) { genreTag in
                                Text(genreTag)
                                    .font(.subheadline)
                                    .frame(width: 150)
                                    .foregroundStyle(.white)
                                    .padding()
                            }
                        }
                    }
                }
                
                //                ForEach(viewModel.albumDetail?.trackList ?? [], id: \.title) { track in
                //                    HStack{
                //                        Text("\(track.number)")
                //                            .bold()
                //                            .padding(.vertical,5)
                //                        Text(track.title)
                //                        Spacer()
                //                        Text(track.length)
                //                    }
                //                    .padding(10)
                //                }
            }
            VStack {
                Text("Similar artits")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                ScrollView(.horizontal) {
                    LazyHStack{
                        ForEach(viewModel.similarArtists, id: \.name) { artist in
                            VStack{
                                Circle()
                                Text(artist.name)
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                            .frame(width: 100, height: 100, alignment: .center)
                        }
                    }
                }
            }
            .foregroundStyle(.white)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear{
            viewModel.getAlbumDetails(albumID: albumInfo.albumUrl ?? "")
        }
    }
}
//
#Preview {
    ZStack{
        Color.black
            .ignoresSafeArea()
        AlbumDetailView(albumInfo: AlbumInfo.firstElement)
            .environment(\.colorScheme, .dark)
    }
}
