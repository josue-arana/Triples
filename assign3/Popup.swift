//
//  Popup.swift
//  assign3
//
//  Created by Josue Arana on 4/8/21.
//

import SwiftUI

struct Popup<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool
    let alignment: Alignment
    
    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) {
            self.isPresented = isPresented
            self.alignment = alignment
            popup = content()
        }
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }
    
    
    @ViewBuilder private func popupContent() -> some View {
            GeometryReader { geometry in
                if isPresented {
                    popup
                        .animation(.spring()) // 1.
                        .transition(.offset(x: 0, y: geometry.belowScreenEdge))
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment) // (*)
                }
            }
        }
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}

struct Popup_Previews: PreviewProvider {
    static var previews: some View {
           Preview()
       }

       // Helper view that shows a popup
       struct Preview: View {
           @State var isPresented = false
            @State var name = ""
        let textFieldHeight: CGFloat = 40

           var body: some View {
               ZStack {
                   Color.clear
                   VStack {
                       Button("Toggle", action: { isPresented.toggle() })
                       Spacer()
                   }
               }
               .modifier(Popup(isPresented: isPresented,
                               alignment: .center,
                               content: {
                                LinearGradient(gradient: Gradient(colors: [Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255), Color.blue]), startPoint: .leading, endPoint: .trailing).frame(width: 300, height: 220).cornerRadius(20)
                                VStack{
                                    
                                    Text("Score: \(50)").font(.title).foregroundColor(.white)
                                        .padding(1)
                                    TextField("Your Name", text: $name).padding(25)
                                        .frame(width: 160, height: textFieldHeight, alignment: .center)
                                        .foregroundColor(Color.gray)
                                        .background(Color.white).font(.title2).cornerRadius(10)
                                        .padding()
                                    HStack {
                                        Text("Ok")
                                            .fontWeight(.semibold)
                                            .font(.title3).padding(0)
                                            
                                    }
                                    .padding(17)
                                    .foregroundColor(.gray)
                                    .background(Color.white).cornerRadius(50)
                                }
                                
                               }))
           }
       }
    struct Box: View {

        var body: some View {
            GeometryReader { geo in
                
                
            }
        }
    }
}
