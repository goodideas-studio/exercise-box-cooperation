//
//  ViewController.swift
//  Game
//
//  Created by JeremyXue on 2018/5/15.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit

struct RPS {
    static let paper = "paper"
    static let rock = "rock"
    static let scissors = "scissors"
}

struct GameRule {
    static let win = "win"
    static let lose = "lose"
}


class ViewController: UIViewController {
    
    var gameTimer = Timer()
    var second = 30
    var gameStart = false
    
    let RPSImage = [RPS.paper,RPS.rock,RPS.scissors]
    var player = Player()
    var random = ""
    var winOrLose = ""
    
    //RPS Outlet
    @IBOutlet weak var firstLineImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playerStatusStackView: UIStackView!
    @IBOutlet weak var rpsStackView: UIStackView!
    
    // GameOver view
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var spourtsLabel: UILabel!

    @IBAction func restartGame(_ sender: UIButton) {
        
        gameStart = true
        Player.playRPSCount += 1
        
        UIView.animate(withDuration: 0.5) {
            self.gameView.transform = CGAffineTransform.identity
            self.rpsStackView.transform = CGAffineTransform.identity
        }
        
        self.playerStatusStackView.isHidden = false
        second = 30
        player.life = 3
        player.score = 0
        scoreLabel.text = "Your score：\(player.score)"
        lifeLabel.text = "Your life：\(player.life)"
        
        startTimer()
    }
    
    
    //RPS Action
    
    @IBAction func RPSAction(_ sender: UIButton) {
//        print(RPSImage[sender.tag], random)
        if winOrLose == GameRule.win {
            if winGame(playerChoose: RPSImage[sender.tag], computerChoose: random) {
                imageLeave()
            } else {
                checkLife()
                return
            }
        } else {
            if loseGame(playerChoose: RPSImage[sender.tag], computerChoose: random) {
                imageLeave()
            } else {
                checkLife()
                return
            }
        }
        
        self.firstLineImage.center.x = 0
        self.firstLineImage.center.x -= 300
        self.rpsRandom()

        imageToCenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOver()
        
        rpsRandom()
        firstLineImage.center = self.gameView.center
        
        if UserDefaults.standard.integer(forKey: UserDefaultKey.rpsHighScore) == 0 {
            print("userdefault = 0")
            highScoreLabel.text = "High Score：0"
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imageToCenter() {
        UIView.animate(withDuration: 0.4) {
            self.firstLineImage.center = self.gameView.center
        }
    }
    
    func imageLeave() {
        player.score += 10
        scoreLabel.text = "Your score:\(player.score)"
        
        UIView.animate(withDuration: 0.4) {
            self.firstLineImage.center.x += 500
        }
    }
    
    func rpsRandom() {
        let randomNumber = Int(arc4random() % 3)
        random = RPSImage[randomNumber]
        firstLineImage.image = UIImage(named: random)
        
        if randomNumber / 2 == 0 {
            winOrLose = GameRule.win
            gameTitle.text = "You have to Win"
        } else {
            winOrLose = GameRule.lose
            gameTitle.text = "You have to Lose"
        }
    }
    
    func winGame(playerChoose:String,computerChoose:String) -> Bool {
        switch (playerChoose,computerChoose) {
        case (RPS.paper,RPS.rock):
            return true
        case (RPS.rock,RPS.scissors):
            return true
        case (RPS.scissors,RPS.paper):
            return true
        default:
            return false
        }
    }
    
    func loseGame(playerChoose:String,computerChoose:String) -> Bool {
        switch (playerChoose,computerChoose) {
        case (RPS.rock,RPS.paper):
            return true
        case (RPS.scissors,RPS.rock):
            return true
        case (RPS.paper,RPS.scissors):
            return true
        default:
            return false
        }
    }
    
    func checkLife() {
        player.life -= 1
        lifeLabel.text = "Your life：\(player.life)"
        if player.life < 0 {
            gameOver()
        }
    }
    
    func gameOver() {
        
        let date = getTime()
        let rpsRecord = PlayRecord(title: "RPS Game", score: player.score, date: date)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tableViewController = storyboard.instantiateViewController(withIdentifier: "GameRecordsViewController") as? GameRecordsViewController {
            tableViewController.gameRecordArray.append(rpsRecord)
        }
        
        
        
//        if gameStart {
//            UserDefaults.standard.set(recordDic, forKey: "playRecord")
//        }
//
//        print("UserDefaults：\(UserDefaults.standard.value(forKey: "playRecord")!)")
        
        gameTimer.invalidate()
        
        let highScore = UserDefaults.standard.integer(forKey: UserDefaultKey.rpsHighScore)
        
        if player.score > highScore {
            UserDefaults.standard.set(player.score, forKey: UserDefaultKey.rpsHighScore)
            highScoreLabel.text = "High Score：\(highScore)"
        }
        
       
        
        
        UIView.animate(withDuration: 1) {
            self.gameView.transform = CGAffineTransform(translationX: 1000, y: 0)
            self.rpsStackView.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.playerStatusStackView.isHidden = true
        }
        UIView.animate(withDuration: 2) {
            self.spourtsLabel.alpha = 1
        }
        
    }
    
    func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
        gameTimer.fire()
    }
    
    @objc func countDownTimer() {
        
        second -= 1
        if second == 0 {
            gameOver()
        }
        timerLabel.text = "\(second)"
    }
    
    func getTime() -> String {
        let now = Date()
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd/ HH:mm"
//        print("当前日期时间：\(dformatter.string(from: now))")

        let date = dformatter.string(from: now)
        
        return date
    }
    
    //
    
  @IBAction func goBack(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}

