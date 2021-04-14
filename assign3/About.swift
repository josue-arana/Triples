//
//  About.swift
//  assign3
//
//  Created by Josue Arana on 4/9/21.
//

import SwiftUI

struct About: View {
    
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    @State var rotate = false
    @State var isShown = false
    
    var body: some View {
        
        
        VStack{
            
            HStack{
                Spacer()
                VStack{
                    Text("Triples!")
                        .font(Font.system(size:26, design: .monospaced))
                        .foregroundColor(.black) 
                        .offset(x: orientation == .regular ?  0 : -290)
                        .onAppear(){
                            isShown = true
                        }
                   
                }
                    
                Spacer()
            }.padding()
            
             
           Spacer()
        }.background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255)]), startPoint: .leading, endPoint: .bottomTrailing))
        .modifier(Popup(isPresented: isShown,
                        alignment: .center,
                        content: {
                            
                            Text("By Josue Arana")
                                .font(Font.system(size:18, design: .monospaced))
                                .foregroundColor(.black)
                                .offset(x: orientation == .regular ?  0 : -290, y: orientation == .regular ? -290 : -100)
                                .animation(.easeInOut(duration: 3))
                                
                            
                            
                            VStack{
                                
                                ZStack {
                                    Circle()
                                        .frame(width: 300, height: 300, alignment: .center)
                                    
                                        Text("Triples!").font(Font.system(size: 20, design: .monospaced))
                                            .rotationEffect(Angle(degrees: 0), anchor: .bottomLeading)
                                            .frame(width: 250, height: 100, alignment: .leading)
                                            .foregroundColor(Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255))
                                            
                                            .offset(x:-10)
                                            .rotationEffect(.degrees(rotate ? 0 : 360))
                                            .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false))
                                            .onAppear(){
                                                rotate = true
                                            }
                                    
                                }
                                .rotation3DEffect(
                                    .degrees(75),
                                    axis: (x:15, y:0.5,z:10))
                                .offset(x: 10, y: 80)
                                
                                
                                
                                HStack{
                                    Spacer()
                                    Circle()
                                        .frame(width: 260, height: 260, alignment: .leading)
                                        .rotation3DEffect(
                                            .degrees(70),
                                            axis: (x:350, y:10,z:0))
                                        .opacity(0.1)
                                        
                                        .offset(x: -5, y: 100)
                                    Spacer()
                                }
                                .offset(x: 0, y: -200)
                            }.animation(.spring())
                            
                             
                        }
        
        ))
        
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
