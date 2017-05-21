//
//  ViewController.swift
//  RedditClone
//
//  Created by siwook on 2017. 4. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - PostListViewController: UIViewController

class PostListViewController: UIViewController {

  // MARK : - Property 
  
  @IBOutlet weak var tableView: UITableView!
  var postList = [PostInformation]()
  lazy var slideInMenu : SlideInMenu = {
    let slideInMenu = SlideInMenu()
    slideInMenu.postListVC = self
    return slideInMenu
  }()
 
  // MARK : - View Life Cycle 

  override func viewDidLoad() {
    super.viewDidLoad()
    loadSampleDataFromBundle()
    
  }
  
  // MARK : - Load Sample Data
  
  func loadSampleDataFromBundle() {
    
    // Fetch sample data from JSON file
    if let pathURL = Bundle.main.url(forResource: Constants.Common.SampleJSONInput, withExtension: Constants.Common.JSONType) {
      
      do {
        
        let data = try Data(contentsOf: pathURL)
        
        if let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] {
        
          postList = dictionaryArray.flatMap(PostInformation.init).sorted(by: { $0.upvoteCount > $1.upvoteCount
          })
          
          DispatchQueue.main.async {
            self.tableView?.reloadData()
          }
        }
      } catch let err {
        #if DEBUG
          print(err)
        #endif
      }
    }
  }
  
  // MARK : - Target Action 

  @IBAction func tapRefreshButton(_ sender: UIBarButtonItem) {
 
    slideInMenu.showMenu()
  
  }
  
}

// MARK : - PostListViewController: UITableViewDataSource

extension PostListViewController : UITableViewDataSource {
  
  // MARK : - UITableViewDataSource Methods 
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.PostInfoTableViewCell, for: indexPath) as! PostInformationTableViewCell
    
    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }
  
  func configureCell(cell:PostInformationTableViewCell, indexPath:IndexPath) {
    
    cell.postInfo = postList[indexPath.row]
    cell.upvoteTapAction = {
      self.postList[indexPath.row].upvoteCount += 1
      cell.postInfo = self.postList[indexPath.row]
    }
    cell.downvoteTapAction = {
      self.postList[indexPath.row].upvoteCount -= 1
      cell.postInfo = self.postList[indexPath.row]
    }
  }
}

