//
//  UserListTableViewController.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

// MARK : - BookListTableViewController: UITableViewController 

class BookListTableViewController: UITableViewController {

  
  // MARK : - Property
  
  fileprivate var bookList = [Book]()
  fileprivate let cellID = "cell"
  fileprivate let ref = Database.database().reference(withPath: "book-items")
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    fetchBookListFromFirebase()
    
  }
  
  func fetchBookListFromFirebase() {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    view.addSubview(activityIndicator)
    activityIndicator.center = view.center
    activityIndicator.startAnimating()
    
    ref.observe(.value, with: { snapshot in
      print(snapshot.value as Any)
      var newBookList = [Book]()
      
      for item in snapshot.children {
        let book = Book(snapshot: item as! DataSnapshot)
        newBookList.append(book)
      }
      
      self.bookList = newBookList
      self.tableView.reloadData()
      activityIndicator.removeFromSuperview()
    })
    
  }
  
  
  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    
    cell.textLabel?.text = bookList[indexPath.row].title
    return cell 
  }
  
  // MARK : - Target Actions 
  
  @IBAction func tappedLogOutButton(_ sender: UIBarButtonItem) {
    
    do {
      try Auth.auth().signOut()
    } catch let error {
      print(error.localizedDescription)
    }
   
    dismiss(animated: true, completion: nil)
  }
  
}
