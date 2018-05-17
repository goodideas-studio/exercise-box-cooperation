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
    
    var appLaunchTimes:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appLaunchTimes = UserDefaults.standard.integer(forKey: "appLaunchTimes")
        appLaunchTimes! += 1
        appLaunchTimesLabel.text = "App共開了\(appLaunchTimes!)次"
        UserDefaults.standard.set(appLaunchTimes, forKey: "appLaunchTimes")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        totalGameTimes.text = "一共玩了:\(Record.current.gameOneTimes + Record.current.gameTwoTimes)次"
        coinAmountLabel.text = "\(Record.current.coin)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

