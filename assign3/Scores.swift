//
//  Scores.swift
//  assign3
//
//  Created by Josue Arana on 4/7/21.
//

import SwiftUI
// A view that shows the data for one Restaurant.

 
struct Scores: View {
    
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    var trip : Triples
    var scores: [Score]
    var darkBlue = Color(red: 10 / 255, green: 43 / 255, blue: 110 / 255)
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Leader Board")
                    .font(Font.system(size:24, design: .monospaced))
                    .foregroundColor(.black)
                    .offset( x:80, y:0)
                Spacer()
            }.padding()
//            .background(Color.black)
                
            
            ScrollView{
                
                VStack{
                    ForEach(0..<scores.count, id:\.self) { i  in
                        VStack{
                            
                            HStack{
                                Text("\(i+1).").foregroundColor(darkBlue)
                                    .font(Font.system(size:14, design: .monospaced)).offset(x: 10)
                                if scores[i].name != "" {
                                Text("\(scores[i].name):").foregroundColor(darkBlue)
                                    .font(Font.system(size:14, design: .monospaced)).offset(x: 30)
                                }else{
                                    Text("Anonymous:").foregroundColor(darkBlue)
                                        .font(Font.system(size:14, design: .monospaced)).offset(x: 30)
                                }
                                Spacer()
                                Text("\(scores[i].score)")
                                    .font(Font.system(size:14, design: .monospaced))
                                    .padding(10).foregroundColor(darkBlue)
                                
                                
                            }
                            Text("\(scores[i].strTime)")
                                .font(Font.system(size:10, design: .monospaced))
                                .foregroundColor(Color.gray)
                                .offset(x: orientation == .regular ?  -60 : -180)
                            
                        }
                    }
                }.padding()
            }
              
                
        }.background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255)]), startPoint: .leading, endPoint: .bottomLeading))
        
    }
}

//struct Scores_Previews: PreviewProvider {
//    static var previews: some View {
//        Scores(scores: [Score])
//    }
//}
