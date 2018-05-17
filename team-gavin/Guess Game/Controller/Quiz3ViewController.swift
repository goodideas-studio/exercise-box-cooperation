//
//  Quiz3ViewController.swift
//  gamePractice
//
//  Created by Morris on 2018/5/15.
//  Copyright © 2018年 Morris. All rights reserved.
//

import UIKit

class Quiz3ViewController: UIViewController {
    
    var scoreFromQuiz2:Int?
    var scoreInQuiz3:Int?
    var playTimesFromGuess = 0
    
    @IBOutlet weak var guessLeftOutlet: UIButton!
    
    @IBOutlet weak var guessMidOutlet: UIButton!
    
    @IBOutlet weak var guessRightOutlet: UIButton!
    
    var counter = 20
    var timer = Timer()
    
    
    @IBAction func giveUpButton(_ sender: UIBarButtonItem) {
        scoreInQuiz3 = 0 + scoreFromQuiz2!
        performSegue(withIdentifier: "goResult", sender: self)
        print("ScoreInQuiz3\(scoreInQuiz3)")
    }
    
    @IBOutlet var animationView: UIView!
    
    @IBAction func goResultButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goResult", sender: self)
    }
    func hiddenAnswerButton(){
        guessLeftOutlet.isHidden = true
        guessMidOutlet.isHidden = true
        guessRightOutlet.isHidden = true
    }
    
    @IBAction func guessAnswerLeftPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        displayPickerView(true)
        if let score = scoreFromQuiz2{
            scoreInQuiz3 = score + 1
        }
        print("ScoreInQuiz3\(scoreInQuiz3)")
        hiddenAnswerButton()
    }
    @IBAction func guessAnswerMidPressed(_ sender: Any) {
        
        timer.invalidate()
        displayPickerView(true)
        if let score = scoreFromQuiz2{
            scoreInQuiz3 = score + 1
        }
        print("ScoreInQuiz3\(scoreInQuiz3)")
        hiddenAnswerButton()
    }
    @IBAction func guessAnswerRightPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        displayPickerView(true)
        if let score = scoreFromQuiz2{
            scoreInQuiz3 = score + 1
        }
        print("ScoreInQuiz3\(scoreInQuiz3)")
        hiddenAnswerButton()
    }
    
    func displayPickerView(_ show:Bool){
        
        for bottomContraints in view.constraints {
            if bottomContraints.identifier == "bottom" {
                bottomContraints.constant = (show) ? -200 : view.frame.height / 3
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultViewController {
            vc.scoreForResult = scoreInQuiz3
        }
        
    }
    @objc func UpdateTimer() {
        counter = counter - 1
        navigationItem.title = String(counter)
        
        if counter == 0 {
            print("ScoreInQuiz3\(scoreInQuiz3)")
            
            scoreInQuiz3 = 0 + scoreFromQuiz2!
            timer.invalidate()
            counter = 20
            navigationItem.title = String(counter)
            performSegue(withIdentifier: "goResult", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(animationView)
        let selectViewHeight = view.frame.height / 5
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalToConstant: selectViewHeight).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        let bottomContraints = animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: selectViewHeight)
        bottomContraints.isActive = true
        bottomContraints.identifier = "bottom"
        animationView.layer.cornerRadius = 10
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
        self.navigationItem.title = String(counter)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Quiz 3"
        timer.invalidate()
        counter = 20
        
    }
}
