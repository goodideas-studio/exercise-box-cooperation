//
//  BlackJackVC.swift
//  SojTeamGame
//
//  Created by Peichun Tsai on 2018/5/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit
import GameKit

class BlackJackVC: UIViewController {

    var bankerRandonDistribution:GKShuffledDistribution?
    var bankerIndex:Int?
    var bankerCard: Int!
    var gamerCard: Int!
    var countdownTimer = Timer()
    var countdownTime = 30
    var tag = 0
    var bankerCurrent = 0
    var gamerCurrent = 0
    var gamePlay = 0
    var defaultChips = 100
    var isPlaying:Bool = false
    
    @IBOutlet weak var position1: UIImageView!
    @IBOutlet weak var position2: UIImageView!
    @IBOutlet weak var position3: UIImageView!
    @IBOutlet weak var position4: UIImageView!
    @IBOutlet weak var position5: UIImageView!
    @IBOutlet weak var position6: UIImageView!
    
    @IBOutlet weak var cardposition1: UIImageView!
    @IBOutlet weak var cardposition2: UIImageView!
    @IBOutlet weak var cardposition3: UIImageView!
    @IBOutlet weak var cardposition4: UIImageView!
    
    @IBOutlet weak var cardposition5: UIImageView!
    
    @IBOutlet weak var cardposition6: UIImageView!
    
    @IBOutlet weak var dealBtnOutlet: UIButton!
    
    lazy var cardName:[UIImageView] = [position1,position2,position3,position4,position5,position6]
     lazy var gamerCardName:[UIImageView] = [cardposition1,cardposition2,cardposition3,cardposition4,cardposition5,cardposition6]
    
    var cardList = [1,2,3,4,5,6,7,8,9,10]
    var clubCardList = ["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10"]
    var heartCardList =  ["h1","h2","h3","h4","h5","h6","h7","h8","h9","h10"]
    var bankerCardList = [Int]()
    var gamerCardList = [Int]()
    
    @IBOutlet weak var dealBankerCardImage: UIImageView!
    @IBOutlet weak var dealGamerCardImage: UIImageView!
    
    
    @IBOutlet weak var bankerScoreLabel: UILabel!
    
    @IBOutlet weak var gamerScoreLabel: UILabel!
    
    @IBOutlet weak var bankerScoreWhenLose: UILabel!
    @IBOutlet weak var gamerScoreWhenLose: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var chipsLabel: UILabel!
    
    @IBOutlet weak var bankerWinResult: UIView!
    
    @IBOutlet weak var gamerWinResult: UIView!
    
    @IBOutlet weak var timesUpView: UIView!
    
    
    
    @IBAction func enrollCardButton(_ sender: Any) {
        bankerRandonDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: cardList.count - 1)
       
    }
    
   
    @IBAction func confirmButton(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: nil)
        dealBtnOutlet.isEnabled = true
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func resetView(_ sender: Any) {
        
        bankerWinResult.frame.origin.y = UIScreen.main.bounds.height + 100
        gamerWinResult.frame.origin.y = UIScreen.main.bounds.height + 100
        
    }
    
    
    
    @IBAction func resetButton(_ sender: Any) {
        
    }
    
    @IBAction func hitButton(_ sender: Any) {
        for number in 1..<3 {
            cardName[number - 1].image = UIImage(named: "c\(bankerCardList[number - 1])")
        }
        bankerCurrent = (bankerCardList[0] + bankerCardList[1])
         gamerCurrent = (gamerCardList[0] + gamerCardList[1])
        
        bankerScoreLabel.text = "\(bankerCurrent)"
        gamerScoreLabel.text = "\(gamerCurrent)"
        bankerScoreWhenLose.text = "\(bankerCurrent)"
        gamerScoreWhenLose.text = "\(gamerCurrent)"
        
        if bankerCurrent > gamerCurrent {
            bankerWinResult.isHidden = false
            chipsLabel.text = "\(defaultChips - 50)"
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            
            self.bankerWinResult.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.bankerWinResult.bounds.height / 2)
            
            }, completion: nil)
        }
        else {
            gamerWinResult.isHidden = false
            chipsLabel.text = "\(defaultChips + 50)"
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                
                self.gamerWinResult.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.gamerWinResult.bounds.height / 2)
                
            }, completion: nil)
            
        }
        
        
        print(bankerCurrent)
        print(gamerCurrent)
        
    }
    
    func timesUp() {
        timesUpView.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            
            self.timesUpView.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.timesUpView.bounds.height / 2)
            
        }, completion: nil)
        
    }
    
    
    @IBAction func dealButton(_ sender: Any) {
        dealBtnOutlet.isEnabled = false
        
//        gamePlay += 1
//        Record.current.gameTwoTimes = gamePlay + Record.current.gameTwoTimes
//        UserDefaults.standard.set(Record.current.gameTwoTimes, forKey: "BlackJackCount")
        startTimer()
        dealCard()
    }
    
    func dealCard() {
        dealCardForFirstRound()
    }
    
    
    func dealCardForFirstRound() {
        

        bankerRandonDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: cardList.count - 1)
        position1.image = UIImage(named: "card_front0")
        position2.image = UIImage(named: "card_front0")
       
        for _ in 0..<2 {
            self.bankerIndex = self.bankerRandonDistribution?.nextInt()
            bankerCard = cardList[bankerIndex!]
            bankerCardList.append(bankerCard)
            print("莊家點數：\(bankerCard)")
            print("莊家牌組：\(bankerCardList)")
            
        }
    
        
        let gamerRandonDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: cardList.count - 1)
        
        for number in 0..<2 {
            let index = gamerRandonDistribution.nextInt()
            gamerCard = cardList[index]
            gamerCardList.append(gamerCard)
            print("玩家點數：\(gamerCard)")
            print("玩家牌組：\(gamerCardList)")
            gamerCardName[number].image = UIImage(named: "h\(gamerCard!)")
        }
            

    }
    
    
    // MARK: - Timer
    func startTimer() {
        if isPlaying == false{
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isPlaying = true
        }
        
    }
    
    @objc func updateTimer() {
        timerLabel.text = "Time: \(countdownTime)"
        if countdownTime != 0 {
            countdownTime -= 1
        }
        else {
            endTimer()
            timesUp()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年M月d日 H:m"
            let dateString = dateFormatter.string(from: Date())
                Record.current.gameTwoTimes += 1
                UserDefaults.standard.set(Record.current.gameTwoTimes, forKey: "gameTwoTimes")
            Record.current.addRecordScore(gameScore: Int(chipsLabel.text!)!)
            Record.current.addRecordGame(gameName: "BlackJacks")
            Record.current.addRecordDate(gameDate: dateString)
            UserDefaults.standard.set(max(Int(chipsLabel.text!)!, UserDefaults.standard.integer(forKey: "gameTwoScore")), forKey: "gameTwoScore")
        }
    }
    
    func endTimer() {
        
        
        
        countdownTimer.invalidate()
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bankerWinResult.isHidden = true
        gamerWinResult.isHidden = true
        timesUpView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    


}
