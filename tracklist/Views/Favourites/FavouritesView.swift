import Variablur
import SwiftUI

struct FavouritesView: View {
    
    var body: some View {
        ScrollView(){
            // Replace with a design
            Text("VUALT")
                .font(.system(size: 90))
                .bold()
                .variableBlur(radius: 30) { geometryProxy, context in
                    context.fill(
                        Path(geometryProxy.frame(in: .local)),
                        with: .linearGradient(
                            .init(colors: [.clear, .white]),
                            startPoint: .zero,
                            endPoint: .init(x: 0, y: geometryProxy.size.height/0.18)
                        )
                    )
                }
                .frame(height: 120)
            ScrollView(.horizontal){
                HStack{
                    ForEach(HomeViewCardFeature.allCases){ category in
                        Text(category.rawValue)
                            .frame(height: 15)
                            .padding(6)
                            .padding(.horizontal)
                            .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke()
                            )
                    }
                }
            }
            VStack {
                HStack{
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 200, height: 260)
                    VStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 150, height: 125)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 150, height: 125)
                    }
                }
                Text("Genres")
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0..<4){_ in
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 80, height: 150)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Bookmarked")
    }
}

#Preview {
    FavouritesView()
}
