//
//  PlayerModel.swift
//  Game
//
//  Created by JeremyXue on 2018/5/15.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import Foundation

struct Player {
    var life = 3
    var score = 0
    static var correctCount = 0
    static var playRPSCount = 0
    static var playGuessCount = 0
}

struct UserDefaultKey {
    static let rpsHighScore = "rpsHighScore"
    static let playRpsCount = "rpsCount"
    static let guessHighScore = "guessHighScore"
    static let playGuessCount = "guessCount"
}

// Game Struct

struct PlayRecord {
    
    let gameTitle:String
    let score:Int
    let date:String
    
    init(title:String,score:Int,date:String) {
        self.gameTitle = title
        self.score = score
        self.date = date
    }
    
}

