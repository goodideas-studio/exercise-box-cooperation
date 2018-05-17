//
//  HomeViewController.swift
//  gamePractice_withGavin
//
//  Created by Morris on 2018/5/16.
//  Copyright © 2018年 Morris. All rights reserved.
//

import UIKit

class HomeViewController:UIViewController{
    @IBAction func backSegue(_ segue:UIStoryboardSegue){
        
    }
    
    var resultFromGuess:String = ""
    
    
    
    @IBOutlet weak var guessTimesLabel: UILabel!
    
    @IBOutlet weak var guessScoreLabel: UILabel!
    
    @IBOutlet weak var diceScoreLabel: UILabel!
    @IBOutlet weak var diceTimesLabel: UILabel!
    @IBOutlet weak var diceView: UIView!
    
    @IBOutlet weak var questionView: UIView!
    
    @IBOutlet weak var guessOutlet: UIButton!
    
    @IBOutlet weak var questionOutlet: UIButton!
    
    @IBAction func goGuessPressed(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        questionView.layer.cornerRadius = 10


        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC willAppear")
        print(UserDefaults.standard.integer(forKey: "highScoreInGuess"))
        var playTimesFromGuess = "\(UserDefaults.standard.integer(forKey: "playTimesInGuess"))"
        
        guessTimesLabel.text = "\(playTimesFromGuess) 次"
        
        
        guessScoreLabel.text = "\(UserDefaults.standard.integer(forKey: "highScoreInGuess")) / 3題"
        
    }
}
