import SwiftUI

struct popOver: View {
    @State var isShowingPopover: Bool = true
    var titleText: String
    var bodyText: String
    
    var body: some View {
        VStack{
            Text("Explination")
                .onTapGesture {
                    isShowingPopover.toggle()
                }
                .explanatory(isPresented: $isShowingPopover,
                             title: titleText,
                             body: bodyText)
            
        }
        
    }
}
#Preview {
    popOver(titleText: "Upload your first item",
            bodyText:"Uploading your first item, takes us one step closer to generating your first look!")
}


struct Explination: ViewModifier {
    var title: String
    var body: String
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .popover(isPresented: $isPresented,
                     attachmentAnchor: .point(UnitPoint.bottom),
                     arrowEdge: .top, content: {
                VStack(alignment: .leading){
                    HStack{
                        Text(title)
                            .bold()
                            .font(.system(size: 17))
                        Spacer()
                        Button(action: {
                            $isPresented.wrappedValue.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .bold()
                        })
                    }
                    Text(body)
                        .font(.system(size: 13))
                        .frame(minHeight: 40,maxHeight: .infinity)
                    
                }
                .foregroundStyle(.black)
                .padding()
                .presentationCompactAdaptation(PresentationAdaptation.popover)
            })
    }
}

extension View {
    func explanatory(isPresented: Binding<Bool>,title: String,body: String) -> some View {
        modifier(Explination(title: title, body: body, isPresented: isPresented))
    }
}
