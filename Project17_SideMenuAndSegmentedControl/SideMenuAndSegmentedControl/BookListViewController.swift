//
//  ViewController.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 6. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Foundation

// MARK : - BookListViewController : UIViewController

class BookListViewController: UIViewController {

  // MARK : - Property 
  
  @IBOutlet weak var tableView: UITableView!
  var bookList = [Book]()
  
  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchBookInfo()
  }
  
  func fetchBookInfo() {
    
    guard let bookListJSONUrl = Bundle.main.url(forResource: "bookList", withExtension: "json") else {
      return
    }
    
    do {
      let bookListData = try Data(contentsOf: bookListJSONUrl)
      
      guard let bookListDictArray = try JSONSerialization.jsonObject(with: bookListData, options: .allowFragments) as? [[String:Any]] else {
        return
      }
      
      bookList = bookListDictArray.flatMap {
        return Book(dictionary: $0)
      }
      
      print(bookList)
    
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
}


// MARK : - BookListViewController : UITableViewDataSource

extension BookListViewController : UITableViewDataSource {
  
  // MARK : - TableView DataSource Methods
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.BookItemTableViewCell, for: indexPath) as! BookItemTableViewCell
       
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
}

