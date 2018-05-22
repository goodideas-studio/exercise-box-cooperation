//  GameRecordsViewController.swift
//  Starbug
//
//  Created by 唐嘉伶 on 2018/5/17.
//  Copyright © 2018 PinguMac. All rights reserved.

import UIKit

class GameRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameRecordArray: [[String:Any]] = []
    
    var totalArray = [[String:Any]]()
    
    
    @IBOutlet weak var gameRecordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let array = UserDefaults.standard.array(forKey: "total")  else {
            return
        }
        
        totalArray = UserDefaults.standard.array(forKey: "total") as! [[String : Any]]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //    let array = UserDefaults.standard.array(forKey: "rpsGameArray") as! [Any]
        guard let array = UserDefaults.standard.array(forKey: "StarBug")  else {
            return
        }
        gameRecordArray = UserDefaults.standard.array(forKey: "StarBug") as! [[String : Any]]
        UserDefaults.standard.set(nil, forKey: "StarBug")
        
        totalArray += gameRecordArray
        
        gameRecordTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(totalArray, forKey: "total")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! GameRecordCell
        cell.itemOrderLabel.text = "\(indexPath.row + 1)"
        cell.gameNameLabel.text = "\(totalArray[indexPath.row]["title"]!)"
        cell.PlayedDateLabel.text = "\(totalArray[indexPath.row]["date"]!)"
        cell.gameScoreLabel.text = "\(totalArray[indexPath.row]["score"]!)"
        
        
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
