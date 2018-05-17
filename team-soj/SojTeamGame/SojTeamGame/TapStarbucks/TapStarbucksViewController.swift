import UIKit

class TapStarbucksViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet var attackImageView: UIImageView!
    @IBOutlet weak var knightImageView: UIImageView!
    @IBOutlet weak var monsterNameLabel: UILabel!
    @IBOutlet weak var monsterHPLabel: UILabel!
    @IBOutlet weak var attackButton: UIButton!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var gameEndLabel: UILabel!
    @IBOutlet weak var playerAgainOutlet: UIButton!
    
    var monsterHPLayer: CAGradientLayer!
    
    var score: Int = 0
    var playTimes: Int = UserDefaults.standard.integer(forKey: "gameOneTimes") == 0 ? 0 : UserDefaults.standard.integer(forKey: "gameOneTimes")
    
    var tapStarbucksTimer = Timer()
    var timeCount: Int = 30
    
    let monster = TapStarbucksModel()
    var monsterIndex: Int = 0
    var monsterHP: Int = 0
    
    @IBAction func attack(_ sender: UIButton) {
        
        attackMonster()
        
//        attackImageView.isHidden = false
//        DispatchQueue.main.async {
//            self.attackImageView.isHidden = true
//        }
        
        if monsterHP <= 0 && monsterIndex < 5 {
            monsterIndex += 1
            score += monster.monsterMaxHP[monsterIndex-1]
            scoreLabel.text = "分數: \(score)"
            createMonster(index: monsterIndex)
            createMonsterHPLayer(ratio: 1)
        } else if monsterHP <= 0 && monsterIndex == 5 {
            score += monster.monsterMaxHP[monsterIndex-1]
            monsterIndex += 1
            scoreLabel.text = "分數: \(score)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年M月d日 H:m"
            let dateString = dateFormatter.string(from: Date())
            
            UserDefaults.standard.set(max(score, Record.current.gameOneScore), forKey: "gameOneScore")
            Record.current.addRecordGame(gameName: "tapStarbucks")
            Record.current.addRecordScore(gameScore: score)
            Record.current.addRecordDate(gameDate: dateString)
            coverView.isHidden = false
            tapStarbucksTimer.invalidate()
            gameEndLabel.text = "You Win!!"
        }
        
    }

    @IBAction func playAgainButton(_ sender: Any) {
        
        UserDefaults.standard.set(Record.current.spentCoin(spendCoin: 100), forKey: "coin")
//        Record.current.gameOneTimes += 1
//        UserDefaults.standard.set(Record.current.gameOneTimes, forKey: "gameOneTimes")
        resetGame()
        tapStarbucksTimer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector: #selector( gameTimerCountDown ), userInfo: nil , repeats: true )
        coverView.isHidden = true
        
    }
    
    func resetGame() {
        Record.current.gameOneTimes += 1
        UserDefaults.standard.set(Record.current.gameOneTimes, forKey: "gameOneTimes")
        print(UserDefaults.standard.integer(forKey: "gameOneTimes"))
        print("max: \(UserDefaults.standard.integer(forKey: "gameOneScore"))")
        timeCount = monster.gameTime
        timerLabel.text = "時間剩下：\(timeCount)秒"
        monsterIndex = 0
        createMonster(index: monsterIndex)
        createMonsterHPLayer(ratio: 1)
        score = 0
        scoreLabel.text = "分數：\(score)"
        
        attackImageView.isHidden = true
        
    }
    
    func attackMonster() {

        monsterHP -= 1
        monsterHPLabel.text = "HP: \(monsterHP) / \(monster.monsterMaxHP[monsterIndex])"
        createMonsterHPLayer(ratio: Double(monsterHP) / Double(monster.monsterMaxHP[monsterIndex]))
    }
    
    func createMonster(index: Int) {
        monsterImageView.image = UIImage(named: monster.monsterName[index])
        monsterNameLabel.text = monster.monsterName[index]
        monsterHP = monster.monsterMaxHP[index]
        monsterHPLabel.text = "HP: \(monsterHP) / \(monster.monsterMaxHP[index])"
    }
    
    
    func createMonsterHPLayer(ratio: Double) {
        if let monsterHPLayer = monsterHPLayer {
            monsterHPLayer.removeFromSuperlayer()
        }
        monsterHPLayer = CAGradientLayer()
        let zeroHPColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        let lowHPColor = UIColor(red: 255/255, green: 100/255, blue: 50/255, alpha: 1).cgColor
        let highHPColor = UIColor(red: 213/255, green: 189/255, blue: 121/255, alpha: 1).cgColor
        
        var secondColorLocation = 0.2 / ratio
        let thirdColorLocation = 1 * ratio
        let fourthColorLocation = 1 * ratio
        
        if secondColorLocation > thirdColorLocation {
            secondColorLocation = thirdColorLocation
        }
        monsterHPLayer.frame = CGRect(x: 57, y: 463, width: 300, height: 15)
        monsterHPLayer.startPoint = CGPoint(x:0.0, y:0.5)
        monsterHPLayer.endPoint = CGPoint(x:1.0, y:0.5)
        monsterHPLayer.locations = [0, NSNumber(value: secondColorLocation), NSNumber(value: thirdColorLocation), NSNumber(value: fourthColorLocation)]
        monsterHPLayer.colors = [zeroHPColor, lowHPColor, highHPColor, UIColor.clear.cgColor]
        
        self.view.layer.addSublayer(monsterHPLayer)
        
    }
    
    @objc func gameTimerCountDown() {
        if timeCount > 0 {
            timeCount -= 1
            timerLabel.text = "時間剩下：\(timeCount)秒"
        } else {
            tapStarbucksTimer.invalidate()
            timeCount = monster.gameTime
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年M月d日 H:m"
            let dateString = dateFormatter.string(from: Date())
            
            UserDefaults.standard.set(max(score, Record.current.gameOneScore), forKey: "gameOneScore")
            Record.current.addRecordGame(gameName: "tapStarbucks")
            Record.current.addRecordScore(gameScore: score)
            Record.current.addRecordDate(gameDate: dateString)
            coverView.isHidden = false
            gameEndLabel.text = "時間到了！"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coverView.isHidden = false
        
        monsterImageView.layer.cornerRadius = monsterImageView.bounds.width / 2
        monsterNameLabel.layer.zPosition = 2
        monsterHPLabel.layer.zPosition = 2
        
        playerAgainOutlet.layer.borderWidth = 2
        playerAgainOutlet.layer.borderColor = UIColor.white.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
