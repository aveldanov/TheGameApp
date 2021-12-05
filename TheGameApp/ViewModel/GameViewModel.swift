//
//  GameViewModel.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/3/21.
//

import Foundation


struct GameViewModel{
    var game: Game
    var winner: Bool{
        return game.winner
    }
    
    var ongoing: Bool{
        return game.ongoingGame
    }
    
    var pattern: [Int]{
        return game.pattern
    }
}

