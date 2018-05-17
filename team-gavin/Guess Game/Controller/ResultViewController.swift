//
//  ResultViewController.swift
//  gamePractice
//
//  Created by Morris on 2018/5/15.
//  Copyright © 2018年 Morris. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    var scoreForResult:Int?
    
//    var highScoreInGuess:Int?
    
    var highestScore:Int?
    
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var restartOutlet: UIButton!
    
    @IBAction func restartButton(_ sender: UIButton) {
        scoreForResult = 0
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Quiz1ViewController{
            vc.scoreInQuiz1 = 0
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "\(scoreForResult!) 題！"
        
        restartOutlet.layer.cornerRadius = 30
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.highestScore = UserDefaults.standard.integer(forKey: "highScoreInGuess")
        print("題數",self.highestScore!)
        if scoreForResult! >= self.highestScore! {
            
            UserDefaults.standard.set(scoreForResult!, forKey: "highScoreInGuess")
            print(scoreForResult!)
        }
        
    }

    
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("ViewWillDisappear")
////        if scoreForResult! > self.highestScore! {
////
////            UserDefaults.standard.set(scoreForResult!, forKey: "highScoreInGuess")
////            print(scoreForResult!)
////        }
//    }
   
}
