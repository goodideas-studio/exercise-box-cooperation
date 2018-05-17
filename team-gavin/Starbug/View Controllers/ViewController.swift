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
  var launchedTimes = userdefaults.integer(forKey: UserDefaults.Keys.appLaunchTimes)
    APPLaunchedTimesCountLabel.text = "APP 被打開\(launchedTimes)次"
    
    var getConinsRemaining = UserDefaults.getCoinsLeft()
    tokenRemainingLabel.text = "剩餘代幣\(getConinsRemaining)"
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    var getConinsRemaining = UserDefaults.getCoinsLeft()
    tokenRemainingLabel.text = "剩餘代幣\(getConinsRemaining)"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func unwindToMainViewController(_ segue : UIStoryboardSegue) {

  }
}

