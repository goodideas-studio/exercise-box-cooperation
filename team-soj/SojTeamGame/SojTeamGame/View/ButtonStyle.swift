//
//  ButtonStyle.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation
import UIKit

class CornerButton:UIButton{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        self.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5).cgColor
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 1
    }
}
