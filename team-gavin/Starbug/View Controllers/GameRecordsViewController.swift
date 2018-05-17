//  GameRecordsViewController.swift
//  Starbug
//
//  Created by 唐嘉伶 on 2018/5/17.
//  Copyright © 2018 PinguMac. All rights reserved.

import UIKit

class GameRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var gameRecordArray: [[String:Any]] = []
  
  
  @IBOutlet weak var gameRecordTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
    
  override func viewWillAppear(_ animated: Bool) {
//    let array = UserDefaults.standard.array(forKey: "rpsGameArray") as! [Any]
    gameRecordArray = UserDefaults.standard.array(forKey: "rpsGameArray") as! [[String : Any]]
    print(gameRecordArray)
    gameRecordTableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return gameRecordArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! GameRecordCell
    cell.itemOrderLabel.text = "\(indexPath.row + 1)"
    cell.gameNameLabel.text = "\(gameRecordArray[indexPath.row]["title"]!)"
    cell.PlayedDateLabel.text = "\(gameRecordArray[indexPath.row]["date"]!)"
    cell.gameScoreLabel.text = "\(gameRecordArray[indexPath.row]["score"]!)"
    
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 46
  }
  
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let aView = UIView()
    return aView
  }
  
}
