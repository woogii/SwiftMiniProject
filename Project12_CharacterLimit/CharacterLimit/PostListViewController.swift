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
  
  // MARK : - View Life Cycle 

  override func viewDidLoad() {
    super.viewDidLoad()
    loadSampleDataFromBundle()
    
  }
  
  // MARK : - Load Sample Data
  
  func loadSampleDataFromBundle() {
    
    // Fetch sample data from JSON file
    if let path = Bundle.main.path(forResource: Constants.Common.SampleJSONInput, ofType: Constants.Common.JSONType) {
      
      do {
        
        let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        
        if let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] {
        
          postList = dictionaryArray.flatMap(PostInformation.init)
          
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
 
    // Sort Post Information List
    postList = postList.sorted(by:{
      return $0.upvoteCount < $1.upvoteCount
    })
      
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.tableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
  }
  
  // MARK : - Prepare For Segue 
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.SegueIdentifier.ShowSubmitNewTopicVC {
      if let destinationVC = segue.destination as? SubmitNewTopicViewController {
        destinationVC.delegate = self
      }
    }
  }
}

// MARK : - PostListViewController: SubmitNewTopicViewControllerDelegate

extension PostListViewController : SubmitNewTopicViewControllerDelegate {

  // MARK : - SubmitNewTopicViewControllerDelegate Method
  
  func updateListAfterSubmittingNewTopic(newTopic:PostInformation) {
    
    postList.append(newTopic)
    postList = postList.sorted(by:{$0.upvoteCount < $1.upvoteCount })
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    
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

