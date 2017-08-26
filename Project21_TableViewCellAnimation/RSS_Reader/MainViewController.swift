//
//  MainViewController.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit


// MARK : - MainViewController: UIViewController

class MainViewController: UITableViewController {

  // MARK : - Properties
  
  
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    
    registerTableViewCell()
    
    RestClient.sharedInstance.requestNews(with: "techCrunch") { (result, error) in
      
      guard error == nil else {
        return
      }
      
      print(result!)
    }
  }
  
  private func registerTableViewCell() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellID.NewsCell)
  }
  
  
  
  // MARK : - UITableViewDataSource Methods 
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.NewsCell, for: indexPath)
    
  
    return cell
  }

}

