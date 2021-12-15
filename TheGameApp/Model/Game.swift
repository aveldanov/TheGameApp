//
//  Game.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/3/21.
//

import Foundation

struct Game: Codable{
    var ongoingGame: Bool
    var winner: Bool
    var pattern: [Int]
}
