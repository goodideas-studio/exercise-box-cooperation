//
//  UserDefaults.swift
//  Starbug
//
//  Created by PinguMac on 2018/5/17.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

extension UserDefaults {
  enum Keys {
    static let appLaunchTimes = "appLaunchTimes"
    static let allGamePlayRounds = "allGamePlayRounds"
    static let coinsLeft = "coinsLeft"
  }
  
  // MARK: - App Launch Time
  static func getAppLaunchTimes() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.appLaunchTimes)
    return storedValue
  }
  
  static func setAppLaunchTimes(round: Int) {
    UserDefaults.standard.set(round, forKey: UserDefaults.Keys.appLaunchTimes)
  }
  
  // MARK: - All Game Play Rounds
  static func getAllGamePlayRounds() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.allGamePlayRounds)
    return storedValue
  }
  
  static func setAllGamePlayRounds(round: Int) {
    UserDefaults.standard.set(round, forKey: UserDefaults.Keys.allGamePlayRounds)
  }
  
  // MARK: - Coins Left
  static func getCoinsLeft() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.coinsLeft)
    return storedValue
  }
  
  static func setCoinsLeft(score: Int) {
    UserDefaults.standard.set(score, forKey: UserDefaults.Keys.coinsLeft)
  }
}
