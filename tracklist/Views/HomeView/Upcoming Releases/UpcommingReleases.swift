import SwiftUI

struct UpcommingReleases: View {
    @StateObject var upcommingReleasesRepository = UpcommingReleasesRepository(metacriticNetworking: MetacriticNetworking())
    @State private var screenWidth: CGFloat = 0
    @State private var cardHeight: CGFloat = 0
    let widthScale = 0.75
    let cardAspectRatio = 1.5
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack(alignment: .leading, spacing: 10, pinnedViews: [.sectionHeaders]) {
                VStack(alignment: .leading){
                    Text("Upcomming")
                        .font(.system(size: 62))
                        .bold()
                    Text("Releases")
                        .font(.system(size: 42))
                }
                .padding(.horizontal)
                
                ForEach(upcommingReleasesRepository.releases) { release in
                    Section(header:
                                Text(release.releaseDate)
                        .foregroundStyle(.black)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background{
                            Color.white
                        }
                            
                    ){
                        ForEach(release.releases.sorted(by: <), id: \.key ){ key, value in
                            if key != ""{
                                HStack{
                                    Text(key)
                                        .bold()
                                        .id("\(key)")
                                    Spacer()
                                    Text(value)
                                }
                                .padding(8)
                            }
                        }
                    }
                    
                }
            }
        }
        .foregroundColor(.white)
        .redacted(reason: upcommingReleasesRepository.releases.count < 1 ? .placeholder : [])
    }
    
}

#Preview {
    UpcommingReleases()
        .darkModePreview()
}



