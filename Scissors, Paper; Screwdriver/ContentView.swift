//
//  ContentView.swift
//  Scissors, Paper; Screwdriver
//
//  Created by Carl Walther on 6/21/21.
//

import SwiftUI
let scissors = Image(systemName: "scissors")


struct ContentView: View {
    @StateObject var game: ScPrPcGame = ScPrPcGame()
    
    
    var body: some View {
        VStack {
            Text("Player's Score:  \(game.getPlayerScore()) ")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.gray)
            Section {
                HStack {
                    ForEach(0..<game.choiceArray.count, id: \.self){ i in
                        if game.choiceArray[i] == game.gameChoice{
                            Image(systemName: game.choiceArray[i].rawValue)
                                .foregroundColor(.pink)
                                .padding()
                        } else {
                            Image(systemName: game.choiceArray[i].rawValue)
                                .padding()
                        }
                    }
                }
                .padding()
                HStack{
                    ForEach(0..<game.goalsArray.count, id: \.self){ i in
                        if game.goalsArray[i] == game.playersGoal {
                            Image(systemName: game.goalsArray[i].rawValue)
                                .foregroundColor(.pink)
                                .padding()
                        } else{
                            Image(systemName: game.goalsArray[i].rawValue)
                                .padding()
                        }
                    }
                }
            }
            Spacer()
            Section {
                VStack{
                    Text("What is your move?")
                        .foregroundColor(.accentColor)
                    HStack{
                        ForEach(0..<game.choiceArray.count, id: \.self){ i in
                            Button( action: {
                                game.gameTurn(playersSelection: game.choiceArray[i])
                            }) {
                                Image(systemName: game.choiceArray[i].rawValue)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
                
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
