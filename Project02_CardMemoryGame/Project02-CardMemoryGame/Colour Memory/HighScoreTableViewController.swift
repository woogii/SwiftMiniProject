//
//  HighScoreTableViewController.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 4. 24..
//  Copyright © 2016년 siwook. All rights reserved.
//

import Foundation
import UIKit 

// MARK : - HighScoreTableViewController : UIViewController

class HighScoreTableViewController : UIViewController {
    
    // MARK : - Property
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableviewTopConstraint: NSLayoutConstraint!
    var highScoreList = [ScoreList]()
    var score:Int? = nil
    var rank:Int? = nil
    
    // MARK : View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFileForTableViewHeader()
    }
    
    func registerNibFileForTableViewHeader() {
        
        let nib = UINib(nibName: Constants.HighScoreTableViewHeaderNib , bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: Constants.HighScoreTableViewHeaderIdentifier)
        
    }

    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        
        setScoreValue()
        setRankValue()
    }
    
    func hideExtraRankAndScoreInformation() {
        
        // Hide labels
        scoreLabel.isHidden = true
        rankLabel.isHidden = true
        messageLabel.isHidden = true
    }
    
    func adjustTableViewTopConstraint() {
        
        // Move tableview up
        tableviewTopConstraint.constant = tableviewTopConstraint.constant - CGFloat(Constants.layoutContraintValue)
    }
    
    func setScoreValue() {
        
        // If there is no score value, which means user did not play game
        guard let score = score else {
            hideExtraRankAndScoreInformation()
            adjustTableViewTopConstraint()
            return
        }
        scoreLabel.text = Constants.ResultScoreText + String(score)
    }
    
    func setRankValue() {
        
        // If there is no rank value
        guard let rank = rank else {
            rankLabel.text = Constants.ResultNoRankText
            return
        }
        
        // If rank value is set
        if rank != 0  {
            rankLabel.text = Constants.ResultRankText + String(rank)
        }else {
            rankLabel.text = Constants.ResultNoRankText
        }

    }

}

// MARK : - HighScoreTableViewController : UITableViewDelegate, UITableViewDataSource

extension HighScoreTableViewController : UITableViewDelegate, UITableViewDataSource {
        
    // MARK : UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.NumOfHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath) as! ScoreCell
        
        sortScoreList()
        configureCell(cell: cell,indexPath: indexPath)

        return cell
    }
    
    func configureCell(cell:ScoreCell, indexPath: IndexPath) {
        
        cell.rankLabel.text = String(indexPath.row+1)
        cell.nameLabel.text = highScoreList[indexPath.row].name
      
      guard let score = highScoreList[indexPath.row].score as? Int else {
        return
      }
      
      cell.scoreLabel.text = String(score)
        
    }
    
    func sortScoreList() {
        
        highScoreList.sort(by: {
          
           guard let firstScore = $0.score as? Int, let secondScore = $1.score as? Int else { return false }
          
            // If there are records with same score, then sort records by the 'date' property
            if firstScore == secondScore {
                return $0.recordTime.compare($1.recordTime as Date) == ComparisonResult.orderedDescending
            }
            return firstScore > secondScore
        })

    }
    
    // MARK : - Table view delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.HighScoreTableViewHeaderIdentifier) as! HighScoreTableViewHeader
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    
}
