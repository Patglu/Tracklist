import SwiftUI
import Kingfisher
import Variablur

struct AlbumDetailView: View {
    let albumInfo: AlbumInfo
    @StateObject var viewModel: AlbumDetailViewModel = AlbumDetailViewModel(networkManager: NetworkManager(htmlContentFetcher: HTMLContentFetcher(), apiRequestHandler: APIRequestHandler(), htmlParser: HTMLParser()))
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                KFImage.url(URL(string: viewModel.albumDetail?.coverImageUrl ?? ""))
                .overlay(alignment:.bottom){
                    LinearGradient(gradient:   Gradient(stops: [
                        .init(color: .black, location: 0.0), // Start with black
                        .init(color: Color.black.opacity(1), location: 0.68), // Transition point
                        .init(color: .clear, location: 1.0) // Fully clear
                    ]), startPoint: .bottom, endPoint: .top)
                        .frame(height: 320)
                        .blur(radius: 20)
                        .offset(y: 190.0)
                }
                .variableBlur(radius:35) { geometryProxy, context in
                    context.fill(
                        Path(geometryProxy.frame(in: .local)),
                        with: .linearGradient(
                            Gradient(stops: [
                                .init(color: .clear, location: 0.0), // Start with black
                                .init(color: Color.clear.opacity(0.5), location: 0.8), // Transition point
                                .init(color: .black, location: 1.0) // Fully clear
                            ]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: 0, y: geometryProxy.size.height)
                        )
                    )
                }
                .frame(height: 550)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .drawingGroup()
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
            VStack(spacing: 20){
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
                .offset(y: -30.0)
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
