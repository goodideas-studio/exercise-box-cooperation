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
//    class let current = Record()
    private init(){
        
    }
    
    var coin:Int = UserDefaults.standard.integer(forKey: "coin") == 0 ? 500 : UserDefaults.standard.integer(forKey: "coin")
    
    var gameOneScore:Int = UserDefaults.standard.integer(forKey: "gameOneScore") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameOneScore")
    var gameTwoScore:Int = UserDefaults.standard.integer(forKey: "gameTwoScore") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameTwoScore")
    
    var gameOneTimes:Int = UserDefaults.standard.integer(forKey: "gameOneTimes") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameOneTimes")
    var gameTwoTimes:Int = UserDefaults.standard.integer(forKey: "gameTwoTimes") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameTwoTimes")
    
    var gameOneDates: [String] = UserDefaults.standard.array(forKey: "gameOneDates") == nil ? [] : UserDefaults.standard.array(forKey: "gameOneDates") as! [String]
    
    var recordGameName:[String] = UserDefaults.standard.array(forKey: "recordGameName") == nil ? [] : UserDefaults.standard.array(forKey: "recordGameName") as! [String]
    
    func addRecordGame(gameName:String){
        recordGameName.append(gameName)
        UserDefaults.standard.set(recordGameName, forKey: "recordGameName")
    }
    
    var gameTwoDates: [String] = UserDefaults.standard.array(forKey: "gameTwoDates") == nil ? [] : UserDefaults.standard.array(forKey: "gameTwoDates") as! [String]
    
    var recordGameDate: [String] = UserDefaults.standard.array(forKey: "recordGameDate") == nil ? [] : UserDefaults.standard.array(forKey: "recordGameDate") as! [String]
    
    var recordGameScore:[Int] = UserDefaults.standard.array(forKey: "recordGameScore") == nil ? [] : UserDefaults.standard.array(forKey: "recordGameScore") as! [Int]
    
    func addRecordScore(gameScore:Int){
        recordGameScore.append(gameScore)
        UserDefaults.standard.set(recordGameScore, forKey: "recordGameScore")
    }
    
    func addRecordDate(gameDate:String){
        recordGameDate.append(gameDate)
        UserDefaults.standard.set(recordGameDate, forKey: "recordGameDate")
    }
    
    func addCoin(addCoin: Int)->Int {
        self.coin += addCoin
        UserDefaults.standard.set(self.coin, forKey: "coin")
        return self.coin
    }
    
    
    func spentCoin(spendCoin: Int)->Int {
        self.coin -= spendCoin
        UserDefaults.standard.set(self.coin, forKey: "coin")
        return self.coin
    }
    
}


