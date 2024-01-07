import SwiftUI

struct AlbumDetailView: View {
    private let albumDetail = AlbumDetail.example
    var body: some View {
        ScrollView {
            VStack{
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 450)
                    .foregroundColor(.black)
            }
        }
        .padding()
    }
}

#Preview {
    AlbumDetailView()
}
