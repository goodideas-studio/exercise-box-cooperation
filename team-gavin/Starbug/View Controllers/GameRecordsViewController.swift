//
//  GameRecordsViewController.swift
//  Starbug
//
//  Created by 唐嘉伶 on 2018/5/17.
//  Copyright © 2018 PinguMac. All rights reserved.
//

import UIKit

class GameRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 var tableViewCellTitle = ["game1", "game1","game1", "game1"]
  
  
  @IBOutlet weak var gameRecordTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewCellTitle.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! GameRecordCell
    cell.itemOrderLabel.text = "\(indexPath.row)"
    cell.gameNameLabel.text = "Starbug"
    cell.PlayedDateLabel.text = "2018/05/17 11:30"
    cell.gameScoreLabel.text = "87"
    
    
    return cell
  }
}
