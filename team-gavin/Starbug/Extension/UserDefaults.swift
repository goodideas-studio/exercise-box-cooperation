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
    static let coinsLeft = "coinsLeft"
    static let rpsGameRounds = "rpsGameRounds"
    static let guessGameRound = "guessGameRound"
  }
  
  // MARK: - App Launch Time
  static func getAppLaunchTimes() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.appLaunchTimes)
    return storedValue
  }
  
  static func setAppLaunchTimes(round: Int) {
    UserDefaults.standard.set(round, forKey: UserDefaults.Keys.appLaunchTimes)
  }
  
  // MARK: - Coins Left
  static func getCoinsLeft() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.coinsLeft)
    return storedValue
  }
  
  static func setCoinsLeft(score: Int) {
    UserDefaults.standard.set(score, forKey: UserDefaults.Keys.coinsLeft)
  }
  
  // MARK: - RPS Game Rounds
  static func getRpsGameRounds() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.rpsGameRounds)
    return storedValue
  }
  
  static func setRpsGameRounds(score: Int) {
    UserDefaults.standard.set(score, forKey: UserDefaults.Keys.rpsGameRounds)
  }
  
  // MARK: - Guess Game Round
  static func getGuessGameRound() -> Int {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.guessGameRound)
    return storedValue
  }
  
  static func setGuessGameRound(score: Int) {
    UserDefaults.standard.set(score, forKey: UserDefaults.Keys.guessGameRound)
  }
}
