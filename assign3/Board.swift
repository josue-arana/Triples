//
//  Board.swift
//  assign3
//
//  Created by Josue Arana on 4/9/21.
//

import SwiftUI

struct Board: View {
    @EnvironmentObject var triples: Triples
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    
    @State var board: [[TileView]] = Array(repeating: Array(repeating: TileView(tile: Tile(val:0, id:0,row: 0, col: 0)), count: 4), count: 4)
    @State private var isDone = false
    @State private var gamePressed = false
    @State private var showBoard = false
    @State private var name: String = ""
    @State private var moves: Int = 0
    @State private var gameOptions = ["Random", "Fixed"]
    @State private var selectedOption = "Random"
    @State private var random = true
    @State private var offsetU = false
    @State private var offsetD = false
    @State private var offsetL = false
    @State private var offsetR = false
    @State private var VORHStack = "VStack"
    @State private var darkBlue = Color(red: 10 / 255, green: 43 / 255, blue: 110 / 255)
    var drag: some Gesture {
        DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onEnded { v in
            }
    }
    
    //FUNCTIONS
    func up() {
        triples.collapse(dir: Direction.up)
        triples.spawn()
        isGameDone()
        update()
        moves += 1
    }
    func down() {
        triples.collapse(dir: Direction.down)
        triples.spawn()
        isGameDone()
        update()
        moves += 1
    }
    func left() {
        triples.collapse(dir: Direction.left)
        triples.spawn()
        isGameDone()
        update()
        moves += 1
    }
    func right() {
        triples.collapse(dir: Direction.right)
        triples.spawn()
        isGameDone()
        update()
        moves += 1
    }
    func isGameDone(){
        
        if triples.isFull {
            let clone = Triples()
            clone.board = triples.board
            clone.collapse(dir: Direction.up)
            clone.collapse(dir: Direction.down)
            clone.collapse(dir: Direction.left)
            clone.collapse(dir: Direction.right)
            
            if(clone.board == triples.board){
                self.isDone = true
            }
        }
    }
    func update(){
        for k in 0..<triples.board.count{
            for j in 0..<triples.board.count{
                //create a tileView and assign it to the board[[TileView?]]
                let tileview = TileView(tile: triples.board[k][j] ?? Tile(val: 0, id: 0, row: 0, col: 0))
                board[k][j] = tileview
            }
        }
    }
    func newGame(random:Bool) {
        triples.newgame(rand: random)
        update()
    }
    func callSpawn() {
        triples.spawn()
        isGameDone()
        update()
    }
    func resetGame(playerName: String){
        triples.scores.append(Score(score: triples.score, name: playerName, time: Date() ))
        if selectedOption == "Random"{
            newGame(random: true)
            callSpawn()
            callSpawn()
            callSpawn()
            callSpawn()
        }
        else {
            newGame(random: false)
            callSpawn()
            callSpawn()
            callSpawn()
            callSpawn()
        }
        self.moves = 0
    }
    func startGame() {
        if selectedOption == "Random"{
            newGame(random: true)
            callSpawn()
            callSpawn()
            callSpawn()
            callSpawn()
        }
        else {
            newGame(random: false)
            callSpawn()
            callSpawn()
            callSpawn()
            callSpawn()
        }
        self.moves = 0
    }
    
    
    var body: some View { 
         
            
        VStack {
            
            Spacer()
            if orientation == .regular {
                //------- Score Section ------- Portrait
                HStack {
                    Text("Score: \(triples.score)").font(Font.system(size: 24, design: .monospaced))
                }.offset( y: 50)
            }
            
            
            
            HStack {
                //-------  Board Section -------
                ZStack {
                    
                    //------- Score -------
                    HStack {
                        RoundedRectangle(cornerRadius:10.0)
                            .foregroundColor(Color(red: 193 / 255, green: 223 / 255, blue: 230 / 255))
                           .frame( width: orientation == .regular ?  335 : 300, height: orientation == .regular ? 400 : 252)
                            .offset(x: 0, y: 0)
                            .opacity(0.15)
                    }
                    
                    //------- 4x4 Tile Board -------
                    
                        VStack{
                            HStack {
                                ForEach((0...3), id: \.self) {
                                    board[0][$0]
                                        .shadow(color: Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255), radius: 8,
                                                        x: offsetL ? 10 : offsetR ? -3 : 1
                                                        ,
                                                        y: offsetU ? 10 : offsetD ? -3 : 1 )
                                }
                            }
                            HStack {
                                ForEach((0...3), id: \.self) {
                                    board[1][$0].shadow(color: Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255), radius: 8,
                                                        x: offsetL ? 10 : offsetR ? -3 : 1
                                                        ,
                                                        y: offsetU ? 10 : offsetD ? -3 : 1 )
                                }
                            }
                            HStack {
                                ForEach((0...3), id: \.self) {
                                    board[2][$0].shadow(color: Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255), radius: 8,
                                                        x: offsetL ? 10 : offsetR ? -3 : 1
                                                        ,
                                                        y: offsetU ? 10 : offsetD ? -3 : 1 )
                                }
                            }
                            HStack {
                                ForEach((0...3), id: \.self) {
                                    board[3][$0].shadow(color: Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255), radius: 8,
                                                        x: offsetL ? 10 : offsetR ? -3 : 1
                                                        ,
                                                        y: offsetU ? 10 : offsetD ? -3 : 1 )
                                }
                            }
                        }.padding().offset(x: 0, y: 0)
                        .offset(x: offsetL ? -5 : offsetR ? 5 : 0
                                ,
                                y: offsetU ? -5 : offsetD ? 5 : 0 )
                    
                  //-------  Drag Gestures for movement -------
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                    // left
                                    left()
                                    withAnimation{
                                        self.offsetL = true
                                        self.offsetR = false
                                        self.offsetU = false
                                        self.offsetD = false
                                    }
                                }

                                else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                                    // right
                                    right()
                                    withAnimation{
                                        self.offsetL = false
                                        self.offsetR = true
                                        self.offsetU = false
                                        self.offsetD = false
                                    }
                                }
                                else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                                    // up
                                    up()
                                    withAnimation {
                                        self.offsetL = false
                                        self.offsetR = false
                                        self.offsetU = true
                                        self.offsetD = false
                                    }
                                }

                                else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                                    // down
                                    down()
                                    withAnimation{
                                        self.offsetL = false
                                        self.offsetR = true
                                        self.offsetU = false
                                        self.offsetD = true
                                    }
                                }else {
                                    print("no clue") 
                                }
                            }))
            }
            .offset(x: orientation == .regular ?  0 : 40, y: orientation == .regular ? 75 : 150).padding(.bottom, 60)
            
            Spacer()
            
            //-------  Show New Game, Random and Control Buttons  -------
            HStack {
                Spacer()
                
                VStack {
                    
                    //------- Score ------- Landscape
                    if orientation != .regular {
                        HStack {
                            Text("Score: \(triples.score)").font(Font.system(size: 24, design: .monospaced)).offset(x: 0, y: 0)
                        }.offset(x:60, y:-73)
                    }
                    
                    //------- New Game Section -------
                    HStack{
                        //-------  New Game Button -------
                        Button(action: {
                            withAnimation {
                                
                                self.gamePressed.toggle()
                                self.offsetU = false
                                self.offsetD = false
                                self.offsetR = false
                                self.offsetL = false
                                
                                if moves > 0 {
                                    self.isDone = true
                                }
                                else{
                                    startGame()
                                }
                            }
                        }) {
                            HStack {
                                Text("New Game")
                                    .fontWeight(.semibold)
                                    .font(Font.system(size: 20, design: .monospaced))
                                    .padding(0)
                                    
                            }
                            .padding(12)
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.primary, Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255)]), startPoint: .leading, endPoint: .trailing)).cornerRadius(20)
                            .rotationEffect(.degrees(gamePressed ? 360 : 0))
                              
                        }  .offset(y: 20)
                        
                    }
                    
                    
                    //------- Random / Fixed Segmentation  -------
                    VStack {
                        Picker("Chose Random or Fixed", selection: $selectedOption) {
                            ForEach(gameOptions, id: \.self) {
                                Text($0).font(Font.system(size: 12, design: .monospaced))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle()).padding(30)
                        .frame(width:200)
//                        Text("You selected: \(selectedOption)")
                        
                    }.offset(x: 0, y: 0)
                    
                }.padding()
                
                Spacer()
                
                //-------  Show Control buttons: up, left, right, down -------
                VStack{
                     
                    HStack {
                        Button(action: {
                            // Function call
                            up()
                            withAnimation(.interpolatingSpring(
                                mass: 1,
                                stiffness: 180,
                                damping: 5,
                                initialVelocity: 0)) {
                                    self.offsetU = true
                                    self.offsetD = false
                                }
                        }) {
                            Image(systemName: "chevron.up")
                                .padding(10)
                                .frame(width: 50, height: 50, alignment: .center)
                                .background(Color.primary)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .padding(0)
                        }.offset(y: offsetU ? -2 : 0)
                    
                    }.offset(y: 15)
                    
                    HStack {
                        Group{
                            Button(action: {
                                left()
                                withAnimation{
                                    self.offsetL = true
                                    self.offsetR = false
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .padding(10).frame(width: 50, height: 50, alignment: .center)
                                    .background(Color.primary)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                            }.offset(x: offsetL ? -2 : 0)
                        }.offset(x: -10)
                        Group{
                            Button(action: {
                                right()
                                withAnimation{
                                    self.offsetR = true
                                    self.offsetL = false
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .padding(10).frame(width: 50, height: 50, alignment: .center)
                                    .background(Color.primary)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                            }.offset(x: offsetR ? 2 : 0)
                        }.offset(x: 10)
                    }
                    
                    
                    HStack {
                        Button(action: {
                            down()
                            withAnimation{
                                self.offsetD = true
                                self.offsetU = false
                            }
                        }) {
                            Image(systemName: "chevron.down")
                                .padding(10).frame(width: 50, height: 50, alignment: .center)
                                .background(Color.primary)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }.offset(y: offsetD ? 2 : 0)
                    }.offset(y: -15)
                    
                }//end VStack
                .offset(x: -10, y: -10)
                
                Spacer()
                
                
                
            } //Ends Game Button and Controls Section
            .offset(x: orientation == .regular ?  -10 : 400, y: orientation == .regular ? 40 : -100)
            
            if orientation == .regular {
                Spacer()
            }
             
            
        }
        .modifier(Popup(isPresented: isDone,
                        alignment: .center, 
                        content: {
                            
                            ZStack {
                                HStack{
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 95 / 255, green: 191 / 255, blue: 194 / 255), Color.blue]), startPoint: .leading, endPoint: .trailing)
                                       .frame(width: 300, height: 300)
                                       .cornerRadius(20)
                                       
                                }.border(Color.white, width: 10)
                             
                                VStack{
                                    Text("Score: \(triples.score)")
                                        .font(Font.system(size: 24, design: .monospaced))
                                        .foregroundColor(.white)
                                         .padding(1)
                                    TextField("Your Name", text: $name).padding(25)
                                        .frame(width: 160, height: CGFloat(40), alignment: .center)
                                        .foregroundColor(Color.gray)
                                        .background(Color.white)
                                        .font(Font.system(size: 16, design: .monospaced))
                                        .cornerRadius(10)
                                        .padding()
                                     HStack {
                                        Button(action: {
                                            isDone.toggle()
                                            resetGame(playerName: name)
                                        }) {
                                         Text("Ok")
                                             .fontWeight(.semibold)
                                            .font(Font.system(size: 16, design: .monospaced))
                                             .padding(10)
                                        }
                                             
                                     }
                                     .padding(5)
                                     .foregroundColor(.gray)
                                     .background(Color.white)
                                     .cornerRadius(50)
                                 }
                            }.offset(x: orientation == .regular ?  0 : 40, y: orientation == .regular ? -15 : 15)
                            
                         
                        }
        
        ))
            
//        }//End main Vstack
    }//End body
}
 
struct BoardView: View {
    
    @EnvironmentObject var triples: Triples
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        
        if verticalSizeClass == .regular {
            ScrollView {
                    VStack{
                        Board().environmentObject(triples)
                    }
            }
        } else {
            ScrollView(.horizontal) {
                    HStack{
                        Board().environmentObject(triples)
                    }
            }
        }
    }
}
 
