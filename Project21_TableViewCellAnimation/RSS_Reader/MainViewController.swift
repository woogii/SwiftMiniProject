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
  let cellID = "cell"
//  private let techFeedParser : MWFeedParser = {
//    
//    guard let techFeedUrl = URL(string: Constants.TechRssFeedURL) else {
//      return MWFeedParser()
//    }
//    guard let techFeedParser = MWFeedParser(feedURL: techFeedUrl) else {
//      return MWFeedParser()
//    }
//    techFeedParser.connectionType = ConnectionTypeAsynchronously
//    techFeedParser.feedParseType = ParseTypeFull
//    return techFeedParser
//  }()
//  fileprivate var techFeedItems = [MWFeedItem]()

  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    
    registerTableViewCell()
    
    
  }
  
  private func registerTableViewCell() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
  }
  
  
  
  // MARK : - UITableViewDataSource Methods 
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath)
    
  
    return cell
  }

}

