//
//  GameListViewController.swift
//  Starbug
//
//  Created by 唐嘉伶 on 2018/5/17.
//  Copyright © 2018 PinguMac. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController {
  @IBAction func backSegue(_ segue:UIStoryboardSegue){
    
  }
    @IBOutlet weak var rpsOutlet: UIButton!
    @IBOutlet weak var guessOutlet: UIButton!
    @IBAction func goGuessGame(_ sender: Any) {
    var tempCoinsRemaining = UserDefaults.getCoinsLeft()
    if tempCoinsRemaining < 100 {
      goGuessGameBtn.isEnabled = false
      let alert = pompAlertVC(title: "Sorry", msg: "Yo dont have enough $$", actTitle: "Come back next time")
      self.present(alert, animated: true, completion: nil)
    } else {
      goRPSGameBtn.isEnabled = true
      goGuessGameBtn.isEnabled = true
      var guessGameRounds = UserDefaults.getGuessGameRound()
      guessGameRounds += 1
      UserDefaults.setGuessGameRound(score: guessGameRounds)
      tempCoinsRemaining -= 100
    }
    print(tempCoinsRemaining)
    UserDefaults.setCoinsLeft(score: tempCoinsRemaining)
  }
  
  @IBAction func goRPSGame(_ sender: Any) {
    var tempCoinsRemaining = UserDefaults.getCoinsLeft()
    if tempCoinsRemaining < 100 {
      goRPSGameBtn.isEnabled = false
      let alert = pompAlertVC(title: "Sorry", msg: "Yo dont have enough $$", actTitle: "Come back next time")
      self.present(alert, animated: true, completion: nil)
    } else {
      goRPSGameBtn.isEnabled = true
      goGuessGameBtn.isEnabled = true
      tempCoinsRemaining -= 100
      var rpsGameRounds = UserDefaults.getRpsGameRounds()
      rpsGameRounds += 1
      UserDefaults.setRpsGameRounds(score: rpsGameRounds)
    }
    UserDefaults.setCoinsLeft(score: tempCoinsRemaining)
  }
  
  @IBOutlet weak var goGuessGameBtn: UIButton!
  @IBOutlet weak var goRPSGameBtn: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    guessOutlet.layer.cornerRadius = 10
    rpsOutlet.layer.cornerRadius = 10

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func pompAlertVC(title: String, msg: String, actTitle: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
    let alertAct = UIAlertAction(title: actTitle, style: .default, handler: nil)
    alert.addAction(alertAct)
    return alert
  }

}
