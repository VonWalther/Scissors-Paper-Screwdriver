
//
//  Scissors_Paper_Screwdriver.swift
//  Scissors, Paper; Screwdriver
//
//  Created by Carl Walther on 6/21/21.
//

import Foundation
import SwiftUI

enum GameChoices: String, Identifiable, CaseIterable{
    case Scissors = "scissors"
    case Paper = "newspaper.fill"
    case PaperClip = "paperclip"
    
    var id: String {self.rawValue}
}

extension GameChoices {
    func doesItBeat(this: GameChoices) -> Bool {
        switch self {
        case .Scissors:
            guard this == GameChoices.Paper else {
                return false
            }
            return true
        case .Paper:
            guard this == GameChoices.PaperClip else {
                return false
            }
            return true
        case .PaperClip:
            guard this == GameChoices.Scissors else {
                return false
            }
            return true
        }
    }
}


enum PlayerGoals: String, Identifiable, CaseIterable {
    case Win = "hand.thumbsup.fill"
    case Loose = "hand.thumbsdown.fill"
    
    var id: String {self.rawValue}
}


class ScPrPcGame: ObservableObject {
    @Published var gameChoice: GameChoices
    @Published var playersGoal: PlayerGoals
    @Published var gameWon: Bool = false
    private var playerScore: Int = 0
    
    private let scoreModifier: Int = 1
    
    init() {
        gameChoice = GameChoices.allCases.randomElement()!
        playersGoal = PlayerGoals.allCases.randomElement()!
    }
    
    private func newGameChoice() -> GameChoices {
        return GameChoices.allCases.randomElement()!
    }
    
    private func newPlayGoal() -> PlayerGoals {
        PlayerGoals.allCases.randomElement()!
    }
    
    private func increasePlayerScore() {
        playerScore += scoreModifier
    }
    
    private func decreesPlayerScore() {
        playerScore -= scoreModifier
    }
    
    func getPlayerScore() -> Int {
        playerScore
    }
    
    
    private func checkPlayersSelection(of choice: GameChoices) -> Bool {
        // Objective
        switch playersGoal {
        case .Win:
            if choice.doesItBeat(this: gameChoice) {
                return true
            } else {
                return false
            }
        case .Loose:
            guard choice.doesItBeat(this: gameChoice) else {
                return true
            }
                return false
        }
    }
    
    func gameTurn(playersSelection: GameChoices) {
        if checkPlayersSelection(of: playersSelection) {
            increasePlayerScore()
        } else {
            decreesPlayerScore()
        }
        if playerScore >= 10 {
            gameWon = true
        } else {
            gameChoice = newGameChoice()
            playersGoal = newPlayGoal()
        }
    }
    
    func printGameState(){
        var gameState: String = ""
        if !gameWon {
        gameState += "Game Choice: \(gameChoice)\n"
        gameState += "Player Goal is to, \(playersGoal)\n"
        gameState += "Score: \(playerScore)\n"
        } else {
            gameState += "YOU WON!!!!!!!"
        }
        print(gameState)
    }
    
 
    
}

var game = ScPrPcGame()


for _ in 0...10 {
    let randChoice = GameChoices.allCases.randomElement()!
    print("Player Choice: \(randChoice)")
    game.printGameState()
    game.gameTurn(playersSelection: randChoice)
}



