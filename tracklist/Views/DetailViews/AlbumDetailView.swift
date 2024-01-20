import SwiftUI

struct AlbumDetailView: View {
    let albumInfo: AlbumInfo
    @StateObject var viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    
    
    
    var body: some View {
        ScrollView {
            VStack{
                AsyncImage(url: URL(string: viewModel.albumDetail?.coverImageUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 450)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .overlay(alignment: .bottomTrailing){
                    Text(viewModel.albumDetail?.releaseYear ?? "")
                        .padding(8)
                        .bold()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .padding(.bottom,25)
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
                Text(viewModel.albumDetail?.title ?? "")
                    .frame(height: 70)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .bold()
                HStack{
                    Text(viewModel.albumDetail?.artist ?? "")
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
        }
        .ignoresSafeArea(edges: .top)
        .onAppear{
            viewModel.getAlbumDetails(albumID: albumInfo.albumUrl ?? "")
        }
    }
}
//
//#Preview {
////    AlbumDetailView(albumDetail: .example)
////    AlbumDetailView(albumInfo: AlbumInfo)
//}
