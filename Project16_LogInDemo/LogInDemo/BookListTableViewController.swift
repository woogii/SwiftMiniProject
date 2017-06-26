//
//  UserListTableViewController.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import FirebaseAuth

class BookListTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {

    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  @IBAction func tappedLogOutButton(_ sender: UIBarButtonItem) {
    
    do {
      try Auth.auth().signOut()
    } catch let error {
      print(error.localizedDescription)
    }
   
    dismiss(animated: true, completion: nil)
  }
  
}
