//
//  GameRecordCell.swift
//  Starbug
//
//  Created by 唐嘉伶 on 2018/5/17.
//  Copyright © 2018 PinguMac. All rights reserved.
//

import UIKit

class GameRecordCell: UITableViewCell {
  @IBOutlet weak var itemOrderLabel: UILabel!
  
  @IBOutlet weak var gameNameLabel: UILabel!
  
  @IBOutlet weak var gameScoreLabel: UILabel!
  
  @IBOutlet weak var PlayedDateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }

}
