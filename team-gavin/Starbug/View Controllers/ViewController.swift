//
//  ViewController.swift
//  Starbug
//
//  Created by PinguMac on 2018/5/17.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class MainViewCOntroller: UIViewController {
  @IBOutlet weak var APPLaunchedTimesCountLabel: UILabel!
  @IBOutlet weak var APPPlayedTimesLabel: UILabel!
  @IBOutlet weak var tokenRemainingLabel: UILabel!
  let userdefaults = UserDefaults.standard
  override func viewDidLoad() {
    super.viewDidLoad()
    //remove the backItem on next nav VC
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

  var launchedTimes = userdefaults.integer(forKey: UserDefaults.Keys.appLaunchTimes)
    APPLaunchedTimesCountLabel.text = "APP 被打開\(launchedTimes)次"
    
    var getConinsRemaining = UserDefaults.getCoinsLeft()
    tokenRemainingLabel.text = "剩餘代幣\(getConinsRemaining)"
    
    var rpsGameRounds = UserDefaults.getRpsGameRounds()
    var guessGameRounds = UserDefaults.getGuessGameRound()
    var totalGameRound = rpsGameRounds + guessGameRounds
    APPPlayedTimesLabel.text = "一共玩了\(totalGameRound)次遊戲"
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    var launchedTimes = userdefaults.integer(forKey: UserDefaults.Keys.appLaunchTimes)
    APPLaunchedTimesCountLabel.text = "APP 被打開\(launchedTimes)次"
    var getConinsRemaining = UserDefaults.getCoinsLeft()
    tokenRemainingLabel.text = "剩餘代幣\(getConinsRemaining)"
    
    var rpsGameRounds = UserDefaults.getRpsGameRounds()
    var guessGameRounds = UserDefaults.getGuessGameRound()
    var totalGameRound = rpsGameRounds + guessGameRounds
    APPPlayedTimesLabel.text = "一共玩了\(totalGameRound)次遊戲"

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func unwindToMainViewController(_ segue : UIStoryboardSegue) {

  }
}

