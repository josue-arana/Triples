//
//  ContentView.swift
//  Assign3 : Triples
//
//  Created by Josue Arana on 3/29/21



import SwiftUI


struct ContentView: View {
    
    
    @ObservedObject var triples: Triples = Triples()
    
    var body: some View {
        
         
        TabView {
            BoardView()
                .tabItem {
                Label("Board", systemImage: "gamecontroller").foregroundColor(.black)
            }.offset(y: -20)
            
            Scores(trip: triples, scores: triples.sortScores(score_list: triples.scores))
                .tabItem {
                Label("Scores", systemImage: "list.dash")
            }
            About()
                .tabItem { 
                Label("About", systemImage: "info.circle")
            }
        }.environmentObject(triples)
        
                    
         
    
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View { 
        
        ContentView()
    }
}
