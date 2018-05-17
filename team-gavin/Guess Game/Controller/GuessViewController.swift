//
//  ViewController.swift
//  gamePractice
//
//  Created by Morris on 2018/5/15.
//  Copyright © 2018年 Morris. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

