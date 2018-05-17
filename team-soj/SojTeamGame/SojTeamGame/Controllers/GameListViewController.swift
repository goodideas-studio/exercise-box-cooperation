//
//  GameListViewController.swift
//  SojTeamGame
//
//  Created by EthanLin on 2018/5/17.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum GameChoice:Int{
    case tapStarbucks
    case blackJack
}

class GameListViewController: UIViewController {
    
    let gameList = [Game(name: "TapStarbucks", coin: 100),Game(name: "BlackJack", coin: 100)]
    
    @IBOutlet weak var gameListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        gameListTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension GameListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameListCell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath) as! GameListTableViewCell
        gameListCell.updateCell(game: gameList[indexPath.row])
        return gameListCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * (80/736)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case GameChoice.tapStarbucks.rawValue:
            if Record.current.coin >= 100{
//                Record.current.spentCoin(spendCoin: gameList[indexPath.row].coin)
                performSegue(withIdentifier: "performTapStarbucks", sender: nil)
                print("剩下錢",Record.current.coin)
            }else{
                let alert = UIAlertController(title: "錢不夠", message: "去儲值", preferredStyle: .alert)
                let action = UIAlertAction(title: "確定", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
        case GameChoice.blackJack.rawValue:
            if Record.current.coin >= 100{
                Record.current.spentCoin(spendCoin: gameList[indexPath.row].coin)
                performSegue(withIdentifier: "performBlackJacks", sender: nil)
                print("剩下錢",Record.current.coin)
            }else{
                let alert = UIAlertController(title: "錢不夠", message: "去儲值", preferredStyle: .alert)
                let action = UIAlertAction(title: "確定", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
    
}
