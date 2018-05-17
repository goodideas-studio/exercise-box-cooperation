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
    
    var playRecords = [[String:Any]]()
//    var playRecords = [PlayRecord]()
    
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var restartOutlet: UIButton!
    
    func getTime() -> String {
        let now = Date()
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd/ HH:mm"
        //print("当前日期时间：\(dformatter.string(from: now))")
        
        let date = dformatter.string(from: now)
        
        return date
    }
    
    @IBAction func restartButton(_ sender: UIButton) {

//        guard let playRecord = UserDefaults.standard.object(forKey: "guessPlayRecord") else {
//          UserDefaults.standard.set(playRecords, forKey: "guessPlayRecord")
//          scoreForResult = 0
//          return
//        }
//
//        playRecords = UserDefaults.standard.object(forKey: "guessPlayRecord") as! [PlayRecord]
//        playRecords.append(guessGameRecord)
//
//        UserDefaults.standard.set(playRecords, forKey: "guessPlayRecord")
        
//        let storyBoard = UIStoryboard(name: "GameRecords", bundle: nil)
//
//        if let recordVC = storyBoard.instantiateViewController(withIdentifier: "GameRecordsViewController") as? GameRecordsViewController {
//            recordVC.gameRecordArray.append(guessGameRecord)
//        }
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
            
//            UserDefaults.standard.set(scoreForResult!, forKey: "highScoreInGuess")
//            print(scoreForResult!)
        }
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let date = getTime()
        
        let guessGameRecord = ["title": "Guess Game", "score": scoreForResult!, "date": date] as [String : Any]
        
        playRecords.append(guessGameRecord)
        
        UserDefaults.standard.set(playRecords, forKey: "record2")
        print(UserDefaults.standard.value(forKey:"record2"))
        
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
