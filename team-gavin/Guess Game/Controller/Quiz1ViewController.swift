//
//  quiz1ViewController.swift
//  gamePractice
//
//  Created by Morris on 2018/5/15.
//  Copyright © 2018年 Morris. All rights reserved.
//

import UIKit

class Quiz1ViewController: UIViewController {
    var playTimes = 0
    
    var counter = 20
    var timer = Timer()
    
    
    
    var scoreInQuiz1:Int = 0
    
    @IBOutlet weak var guessOutlet: UIButton!
    
    @IBAction func giveUpButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goQuiz2", sender: self)
        print("scoreInQuiz1\(scoreInQuiz1)")
    }
    @IBAction func continuePressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goQuiz2", sender: self)
        
    }
    @IBOutlet var animationView: UIView!
    @IBOutlet var introView: UIView!
    @IBOutlet weak var continueOutlet: UIBarButtonItem!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBAction func correctButtonPressed(_ sender: UIButton) {
        continueOutlet.isEnabled = true
        displayPickerView(false)
    }
    @IBAction func okPressed(_ sender: Any) {
        
        displayIntroView(false)
        
        playTimes += 1
        
        UserDefaults.standard.set(playTimes, forKey: "playTimesInGuess")
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
        self.navigationItem.title = String(counter)
    }
    
    @objc func UpdateTimer() {
        counter = counter - 1
        navigationItem.title = String(counter)
        
        if counter == 0 {
            
            timer.invalidate()
            counter = 20
            navigationItem.title = String(counter)
            print("scoreInQuiz1\(scoreInQuiz1)")
            performSegue(withIdentifier: "goQuiz2", sender: self)

        }
    }
    
    
    @IBAction func guessButton(_ sender: UIButton) {
        guessOutlet.isHidden = true
        scoreInQuiz1 += 1
        print("scoreInQuiz1\(scoreInQuiz1)")
        displayPickerView(true)
        timer.invalidate()
        
        
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
    func displayIntroView(_ show:Bool){
        
        for bottomContraints2 in view.constraints {
            if bottomContraints2.identifier == "bottom2" {
                bottomContraints2.constant = (show) ? -200 : view.frame.height / 3
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Quiz2ViewController {
            vc.scoreFromQuiz1 = scoreInQuiz1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = 10
        correctButton.layer.cornerRadius = 10
        

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
        //// -----------------------------------////
        view.addSubview(introView)
        introView.translatesAutoresizingMaskIntoConstraints = false
        introView.heightAnchor.constraint(equalToConstant: selectViewHeight).isActive = true
        introView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        introView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        let bottomContraints2 = introView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: selectViewHeight)
        bottomContraints2.isActive = true
        bottomContraints2.identifier = "bottom2"
        introView.layer.cornerRadius = 10
        
        playTimes = UserDefaults.standard.integer(forKey: "playTimesInGuess")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayIntroView(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Quiz 1"
        timer.invalidate()
        counter = 20
    }
}
