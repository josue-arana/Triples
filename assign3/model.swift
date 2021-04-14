//
//  model.swift
//  assign1
//
//  Created by Josue Arana on 3/29/21
//

import Foundation

enum Direction {
    case left
    case right
    case down
    case up
}

struct Tile: Equatable {
    var val : Int
    var id : Int
    var row: Int    // recommended
    var col: Int    // recommended
    
    static func == (l:Tile, r:Tile) -> Bool{
        return l.val == r.val
    }
    
}

struct Score: Hashable {
    var score: Int
    var time: Date
    var strTime: String
    var name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
    
    init(score: Int, name: String, time: Date) {
        self.score = score
        self.name = name
        self.time = time
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd/MM/YY - HH:mm:ss "
        let stringDate = timeFormatter.string(from: time)
        self.strTime = stringDate
    }
}


class Triples: ObservableObject {
    
    @Published var board: [[Tile?]]
    @Published var scores: [Score]
    @Published var score: Int
    @Published var isFull: Bool
    
    //Seed generator
    var seededGenerator: SeededGenerator
    
    init(){
        score = 6
        seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        isFull = false
        scores = [
            Score(score: 400, name: "Cranjis McBasketball", time: Date()),
            Score(score: 300, name: "Jabreakit Jubawdit", time: Date() )
           ]
        board = [[Tile(val: 1, id: 1, row: 0, col: 0), Tile(val: 0, id: 2, row: 0, col: 1), Tile(val: 0, id: 3, row: 0, col: 2), Tile(val: 1, id: 4, row: 0, col: 3)],
                 [Tile(val: 0, id: 5, row: 1, col: 0), Tile(val: 2, id: 6, row: 1, col: 1), Tile(val: 0, id: 7, row: 1, col: 2),Tile(val: 2, id: 8, row: 1, col: 3)],
                 [Tile(val: 0, id: 9, row: 2, col: 0), Tile(val: 0, id: 10, row: 2, col: 1), Tile(val: 0, id: 11, row: 2, col: 2), Tile(val: 0, id: 12, row: 2, col: 3)],
                 [Tile(val: 0, id: 13, row: 3, col: 0),Tile(val: 0, id: 14, row: 3, col: 1),Tile(val: 0, id: 15, row: 3, col: 2), Tile(val: 0, id: 16, row: 3, col: 3) ]] 
        
    }
    
    
    func sortScores(score_list: [Score]) ->  [Score]  {
        
        var hash_nums = [Int:[Score]]()
        
        for elem in score_list{
            let keyExists = hash_nums[elem.score] != nil
            if keyExists {
                hash_nums[elem.score]?.append(elem)
            }else{
                hash_nums[Int(elem.score)] = [elem]
            }
        }
//
        var dictKeys = [Int](hash_nums.keys)
        dictKeys.sort()
        
        
        var sortedScores : [Score] = []
        
            
        for (key) in dictKeys.reversed() {
            for n in hash_nums[key]! {
                sortedScores.append(Score(score: n.score, name: n.name, time: n.time))
            }
        }
        
        return sortedScores
    }
     
    
    
    func newgame(rand: Bool) {
        if rand {
            for k in 0..<board.count{
                for j in 0..<board.count{
                    board[k][j]?.val = 0
                }
            }
            score = 0
            isFull = false
            seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        }
        else{
            for k in 0..<board.count{
                for j in 0..<board.count{
                    board[k][j]?.val = 0
                }
            }
            score = 0
            isFull = false
            //reinitialize seededGenerator
            seededGenerator = SeededGenerator(seed: 14)
        }
    }
    
    
    func spawn(){
        let index = Int.random(in: 1...2, using: &seededGenerator)
        
        var zeros: [(Int, Int)] = []    //[  (0,0) , (0,2) ]
        let length = board.count
        for row in 0..<length{
            for col in 0..<length{
                
                //Find positions with zero value
                if board[row][col]?.val == 0 {
                    zeros.append((row,col))
                }
            }
        }
        
        if zeros.count == 0{
            isFull = true
            return
        }
        
        let zeroIndex = Int.random(in: 0..<zeros.count, using: &seededGenerator)
        let (pX,pY) = zeros[zeroIndex]
        
        board[pX][pY]?.val = index
        //Increment score
        score += index
        
    }
    
    // collapse in specified direction using shift() and rotate()
    func collapse(dir: Direction) {
        switch dir {
        case .left:
            shift()
            
        case .right:
            rotate()
            rotate()
            shift()
            rotate()
            rotate()
            
        case .down:
            rotate()
            shift()
            rotate()
            rotate()
            rotate()
            
        case .up:
            rotate()
            rotate()
            rotate()
            shift()
            rotate()
        }
        
    }
    

    
    // rotate a square 2D Int array clockwise
     func rotate() {
        let length = board.count
        for row in 0..<length{
            for col in row..<length{
               let temp = board[row][col]
                board[row][col] = board[col][row]
                board[col][row] = temp
            }
        }
        for row in 0..<length{
            for col in 0..<(length/2){
               let temp = board[row][col]
                board[row][col] = board[row][length - 1 - col]
                board[row][length - 1 - col] = temp
            }
        }
     }
    
    // collapse to the left
     func shift() {
        let length = board.count
        for i in 0..<length{

            for j in 0..<length-1{

              if(j < board[i].count-1){

                let curr = board[i][j]
                let next = board[i][j+1]
                var sum = curr?.val ?? 0
                sum += next?.val ?? 0
                // print("\(curr)+\(next) =  \(sum) ")
              
                if(curr?.val == 0 ){
                  let temp = board[i][j]
                  board[i][j] = board[i][j+1]
                  board[i][j+1] = temp
                }
                else if((curr?.val == 1 && next?.val == 2) || (curr?.val == 2 && next?.val == 1)){
                    board[i][j]?.val = sum
                    board[i][j+1]?.val = 0
                  score += sum
                }
                else if (curr?.val != 1 && curr?.val != 2 &&
                        next?.val != 1 && next?.val != 2 && curr?.val == next?.val){
                  board[i][j]?.val = sum
                  board[i][j+1]?.val = 0
                  score += sum
                }
              }
            }
            // print(board[i])
        }
     }
    
}


private func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let tempA = a
    a = b
    b = tempA
}
// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2DInts(input: [[Int]]) -> [[Int]] {
    var result: [[Int]] = input
    let length = result.count
    for row in 0..<length{
        for col in row..<length{
           let temp = result[row][col]
           result[row][col] = result[col][row]
           result[col][row] = temp
        }
    }
    for row in 0..<length{
        for col in 0..<(length/2){
           let temp = result[row][col]
           result[row][col] = result[row][length - 1 - col]
           result[row][length - 1 - col] = temp
        }
    }
//    print(result)
    return result
}


private func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let tempA = a
    a = b
    b = tempA
}

// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2D<T>(input: [[T]]) -> [[T]] {
    var result: [[T]] = input
    let length = result.count
    for row in 0..<length{
        for col in row..<length{
           let tempA = result[row][col]
           result[row][col] = result[col][row]
           result[col][row] = tempA
        }
    }
    for row in 0..<length{
        for col in 0..<(length/2){
           let temp = result[row][col]
           result[row][col] = result[row][length - 1 - col]
           result[row][length - 1 - col] = temp
        }
    }
    return result
}
