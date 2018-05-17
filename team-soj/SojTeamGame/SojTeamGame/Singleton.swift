//
//  Singleton.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation

class Record{
    static let current = Record()
    
    private init(){
        
    }
    
    var coin:Int = UserDefaults.standard.integer(forKey: "coin") == 500 ? 500 : UserDefaults.standard.integer(forKey: "coin")
    
    var gameOneScore:Int = UserDefaults.standard.integer(forKey: "gameOneScore") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameOneScore")
    var gameTwoScore:Int = UserDefaults.standard.integer(forKey: "gameTwoScore") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameTwoScore")
    
    var gameOneTimes:Int = UserDefaults.standard.integer(forKey: "gameOneTimes") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameOneTimes")
    var gameTwoTimes:Int = UserDefaults.standard.integer(forKey: "gameTwoTimes") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameTwoTimes")
    
    var gameOneDates: [String] = UserDefaults.standard.array(forKey: "gameOneDates") == nil ? [] : UserDefaults.standard.array(forKey: "gameOneDates") as! [String]
    
    var gameTwoDates: [String] = UserDefaults.standard.array(forKey: "gameTwoDates") == nil ? [] : UserDefaults.standard.array(forKey: "gameTwoDates") as! [String]
    
    func addCoin(addCoin: Int)->Int {
        self.coin += addCoin
        return self.coin
    }
    
    func spentCoin(spendCoin: Int)->Int {
        self.coin -= spendCoin
        return self.coin
    }
    
}
