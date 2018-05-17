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

struct PlayRecord {
    
    let playCount:Int
    let gameItem:String
    let score:Int
    let date:Date
    
    init(playCount:Int,gameItem:String,score:Int,date:Date) {
        self.playCount = playCount
        self.gameItem = gameItem
        self.score = score
        self.date = date
    }
    
}

