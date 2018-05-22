//
//  ViewController.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    
    @IBOutlet weak var appLaunchTimesLabel: UILabel!
    @IBOutlet weak var totalGameTimes: UILabel!
    @IBOutlet weak var coinAmountLabel: UILabel!
    
    //    var appLaunchTimes:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appLaunchTimesLabel.text = "APP共開了\(UserDefaults.standard.integer(forKey: "appLaunchTimes"))次"
        NotificationCenter.default.addObserver(self, selector: #selector(changeLaunchTimes), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    @objc func changeLaunchTimes(){
        appLaunchTimesLabel.text = "APP共開了\(UserDefaults.standard.integer(forKey: "appLaunchTimes"))次"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        totalGameTimes.text = "一共玩了:\(Record.current.gameOneTimes + Record.current.gameTwoTimes)次"
        coinAmountLabel.text = "\(Record.current.coin)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

