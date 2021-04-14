//
//  TileView.swift
//  assign3
//
//  Created by Josue Arana on 3/29/21.
//

import SwiftUI
 

//extension Animation {
//    static func ripple(index: Int) -> Animation {
//        Animation.spring(dampingFraction: 0.9)
//            .speed(2)
//            .delay(0.001 * Double(index))
//    }
//}

struct TileView: View {
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    
    var tile = Tile(val: 0, id: 0, row: 0, col: 0)
        
    init(tile: Tile) {
        self.tile = tile
    }
    
    func chooseTileColor(_ num:Int) -> Color {
        if num == 0{
            return Color.white
        }
        else if num == 1{
            return Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255)
        }
        else if num == 2 {
            return Color.blue
        }
        else{
            return Color(red: 10 / 255, green: 43 / 255, blue: 110 / 255)
        }
    }

    var body: some View {
        Text(tile.val.description)
            .padding()
            .font(tile.val < 12 ? .title : tile.val < 23 ? .title : .title3)
            .frame( width: orientation == .regular ?  65 : 60, height: orientation == .regular ? 80 : 49)
            .background(chooseTileColor(tile.val))
            .cornerRadius(5).foregroundColor(.white)
            .animation(.easeInOut(duration: 0.4))
            
            
    }
}

//struct TileView_Previews: PreviewProvider {
//    static var previews: some View {
//        TileView()
//    }
//}
