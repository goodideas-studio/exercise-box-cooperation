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
    var defaultChips = 100 {
        didSet {
            if defaultChips <= 0 {
                endTimer()
                bankerWinResult.isHidden = true
                bankrupt.isHidden = false
                hitButtonOutlet.isEnabled = true
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                    
                    self.bankrupt.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.bankrupt.bounds.height / 2)
                    
                }, completion: nil)
            }
        }
    }
    var gamePlay = 0
    var isPlaying:Bool = false
    
    // MARK: - UIImageView
    @IBOutlet weak var position1: UIImageView!
    @IBOutlet weak var position2: UIImageView!
    @IBOutlet weak var cardposition1: UIImageView!
    @IBOutlet weak var cardposition2: UIImageView!
    @IBOutlet weak var dealBankerCardImage: UIImageView!
    @IBOutlet weak var dealGamerCardImage: UIImageView!
    // MARK: - UIButton Outlet
    @IBOutlet weak var dealBtnOutlet: UIButton!
    @IBOutlet weak var hitButtonOutlet: UIButton!
    // MARK: - UILabel
    @IBOutlet weak var bankerScoreLabel: UILabel!
    @IBOutlet weak var gamerScoreLabel: UILabel!
    @IBOutlet weak var bankerScoreWhenLose: UILabel!
    @IBOutlet weak var gamerScoreWhenLose: UILabel!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var chipsLabel: UILabel!
    // MARK: - UIView
    @IBOutlet weak var bankerWinResult: UIView!
    @IBOutlet weak var gamerWinResult: UIView!
    @IBOutlet weak var timesUpView: UIView!
    @IBOutlet weak var sameScore: UIView!
    @IBOutlet weak var bankrupt: UIView!
    lazy var cardName:[UIImageView] = [position1,position2]
    lazy var gamerCardName:[UIImageView] = [cardposition1,cardposition2]
    
    var cardList = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    var clubCardList = ["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13"]
    var heartCardList =  ["h1","h2","h3","h4","h5","h6","h7","h8","h9","h10","h11","h12","h13"]
    var bankerCardList = [Int]()
    var gamerCardList = [Int]()
    
    
    
    // MARK: - Reset All Result
    @IBAction func confirmTimesUpButton(_ sender: Any) {
        
        
        dealBtnOutlet.isEnabled = true
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func resetViewButton(_ sender: Any) {
        gamerCardList = []
        bankerCardList = []
        
        dealBtnOutlet.isEnabled = true
        hitButtonOutlet.isEnabled = false
        position1.image = UIImage(named: " ")
        position2.image = UIImage(named: " ")
        cardposition1.image = UIImage(named: " ")
        cardposition2.image = UIImage(named: " ")
        bankerWinResult.frame.origin.y = UIScreen.main.bounds.height + 100
        gamerWinResult.frame.origin.y = UIScreen.main.bounds.height + 100
        sameScore.frame.origin.y = UIScreen.main.bounds.height + 100
    }
    
    
    // MARK: - Run Game
    @IBAction func hitButton(_ sender: Any) {
        hitButtonOutlet.isEnabled = false
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
            defaultChips = defaultChips - 50
            chipsLabel.text = "\(defaultChips)"
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                
                self.bankerWinResult.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.bankerWinResult.bounds.height / 2)
                
            }, completion: nil)
        }
        else if bankerCurrent < gamerCurrent {
            gamerWinResult.isHidden = false
            defaultChips = defaultChips + 50
            chipsLabel.text = "\(defaultChips)"
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                
                self.gamerWinResult.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.gamerWinResult.bounds.height / 2)
                
            }, completion: nil)
        }
        else if bankerCurrent == gamerCurrent{
            sameScore.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                
                self.sameScore.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.sameScore.bounds.height / 2)
                
            }, completion: nil)
        }
        print(bankerCurrent)
        print(gamerCurrent)
    }
    
    func callBankruptView() {
        
    }
    
    
    @IBAction func dealButton(_ sender: Any) {
        
        hitButtonOutlet.isEnabled = true
        dealBtnOutlet.isEnabled = false
        
        startTimer()
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
        if isPlaying == false {
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
            
            dealBtnOutlet.isEnabled = false
            dealBtnOutlet.isEnabled = false
            bankrupt.isHidden = true
            gamerWinResult.isHidden = true
            bankerWinResult.isHidden = true
            sameScore.isHidden = true
            Record.current.gameTwoTimes += 1
            UserDefaults.standard.set(Record.current.gameTwoTimes, forKey: "gameTwoTimes")
            Record.current.addRecordScore(gameScore: Int(chipsLabel.text!)!)
            Record.current.addRecordGame(gameName: "BlackJacks")
            Record.current.addRecordDate(gameDate: DateHelper.shared.convertDateFormat())
            UserDefaults.standard.set(max(Int(chipsLabel.text!)!, UserDefaults.standard.integer(forKey: "gameTwoScore")), forKey: "gameTwoScore")
        }
    }
    
    func endTimer() {
        
        countdownTimer.invalidate()
    }
    
    func timesUp() {
        timesUpView.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            
            self.timesUpView.frame.origin.y = UIScreen.main.bounds.height / 2 - (self.timesUpView.bounds.height / 2)
            
        }, completion: nil)
        
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bankrupt.isHidden = true
        bankerWinResult.isHidden = true
        gamerWinResult.isHidden = true
        timesUpView.isHidden = true
        sameScore.isHidden = true
        hitButtonOutlet.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
