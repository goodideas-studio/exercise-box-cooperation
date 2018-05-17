//
//  RecordTableViewCell.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fakeView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        fakeView.layer.masksToBounds = true
        fakeView.layer.cornerRadius = 5
    }

    func updateCellUI(order:Int,gameName:String,score:Int,time:String){
        orderLabel.text = "\(order)"
        gameNameLabel.text = gameName
        scoreLabel.text = "\(score)分"
        timeLabel.text = time
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
