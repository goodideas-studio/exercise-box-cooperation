//
//  RecordViewController.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordTableView.delegate = self
        recordTableView.dataSource = self
        recordTableView.separatorStyle = .none
        print(Record.current.recordGameScore)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let totalGameTimes = Record.current.gameOneTimes + Record.current.gameTwoTimes
//        return totalGameTimes
        return Record.current.recordGameName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordTableViewCell
        recordCell.gameNameLabel.text = Record.current.recordGameName[indexPath.row]
        recordCell.orderLabel.text = "\(indexPath.row + 1)"
        recordCell.scoreLabel.text = "分數\(Record.current.recordGameScore[indexPath.row])分"
        recordCell.timeLabel.text = "\(Record.current.recordGameDate[indexPath.row])"
        return recordCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * (110/736)
    }
}
