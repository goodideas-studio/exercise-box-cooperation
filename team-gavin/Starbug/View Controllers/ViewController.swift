//
//  ViewController.swift
//  Starbug
//
//  Created by PinguMac on 2018/5/17.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class MainViewCOntroller: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var infoOutlet: UIView!
  @IBOutlet weak var startOutlet: UIButton!
  @IBOutlet weak var gameRecordOutlet: UIButton!
  @IBOutlet weak var rechargeOutlet: UIButton!
  @IBOutlet weak var APPLaunchedTimesCountLabel: UILabel!
  @IBOutlet weak var APPPlayedTimesLabel: UILabel!
  @IBOutlet weak var tokenRemainingLabel: UILabel!
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    appDelegateObserver()
    
    //remove the backItem on next nav VC
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    infoOutlet.layer.cornerRadius = 10
    startOutlet.layer.cornerRadius = 10
    gameRecordOutlet.layer.cornerRadius = 10
    rechargeOutlet.layer.cornerRadius = 10
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    let launchedTimes = UserDefaults.getAppLaunchTimes()
    APPLaunchedTimesCountLabel.text = "APP 被打開\(launchedTimes)次"
    
    let getConinsRemaining = UserDefaults.getCoinsLeft()
    tokenRemainingLabel.text = "剩餘代幣\(getConinsRemaining)"
    
    let rpsGameRounds = UserDefaults.getRpsGameRounds()
    let guessGameRounds = UserDefaults.getGuessGameRound()
    let totalGameRound = rpsGameRounds + guessGameRounds
    APPPlayedTimesLabel.text = "一共玩了\(totalGameRound)次遊戲"
  }
  
  // MARK: - Memory Warning
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  @IBAction func unwindToMainViewController(_ segue : UIStoryboardSegue) {
    
  }
  
  // MARK: - Help Methods
  func appDelegateObserver() {
    let notification = NotificationCenter.default
    
    notification.addObserver(self, selector: #selector(updateLabel), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
  }
  
  
  @objc func updateLabel() {
    let launchedTimes = UserDefaults.getAppLaunchTimes()
    APPLaunchedTimesCountLabel.text = "APP 被打開\(launchedTimes)次"
  }
}

