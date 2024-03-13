import SwiftUI
import Variablur

struct HomeViewV2: View {
    var body: some View {
        ZStack {
            Color(uiColor: UIColor(hex: "#F8FBF8"))
                .ignoresSafeArea()
            VStack{
                Text("ALBUMS")
                    .padding(10)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .fontWeight(.bold)
                
                Text("SINGLES")
                    .padding(10)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .fontWeight(.bold)
            }

        }
        .overlay {
            Image("filmGrain")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
                .colorInvert()
                .blendMode(.multiply)
                .opacity(0.3)
        }

    }
}

#Preview {
    HomeViewV2()
}
