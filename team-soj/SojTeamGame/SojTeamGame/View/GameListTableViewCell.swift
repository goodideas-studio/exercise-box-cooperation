//
//  GameListTableViewCell.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class GameListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fakeView: UIView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var howMuchLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fakeView.layer.masksToBounds = true
        fakeView.layer.cornerRadius = 5
        // Initialization code
    }
    
    func updateCell(game:Game){
        gameNameLabel.text = game.name
        howMuchLabel.text = "\(game.coin)"
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }

}
