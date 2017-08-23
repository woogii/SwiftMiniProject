//
//  MainViewController.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import MWFeedParser

// MARK : - MainViewController: UIViewController

class MainViewController: UITableViewController {

  // MARK : - Properties

  private let techFeedParser : MWFeedParser = {
    
    guard let techFeedUrl = URL(string: Constants.TechRssFeedURL) else {
      return MWFeedParser()
    }
    guard let techFeedParser = MWFeedParser(feedURL: techFeedUrl) else {
      return MWFeedParser()
    }
    techFeedParser.connectionType = ConnectionTypeAsynchronously
    return techFeedParser
  }()

  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    
    setDelegatesForParsers()
    startParsers()
    
  }
  
  func setDelegatesForParsers() {
    techFeedParser.delegate = self
  }
  
  func startParsers() {
    techFeedParser.parse()
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

// MARK : - MainViewController: MWFeedParserDelegate

extension MainViewController : MWFeedParserDelegate {
  
  // MARK : - MWFeedParserDelegate Methods
  
  func feedParserDidStart(_ parser: MWFeedParser!) {
    
  }
  
  func feedParser(_ parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
    
    print(info)
  }
  
  func feedParser(_ parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
    print(item)
  }
  
  func feedParserDidFinish(_ parser: MWFeedParser!) {
    
    
  }
}
