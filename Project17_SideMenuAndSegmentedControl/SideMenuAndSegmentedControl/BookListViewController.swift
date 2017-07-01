//
//  ViewController.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 6. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - BookListViewController : UIViewController

class BookListViewController: UIViewController {

  // MARK : - Property 
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

}

// MARK : - BookListViewController : UITableViewDataSource

extension BookListViewController : UITableViewDataSource {
  
  // MARK : - TableView DataSource Methods
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "bookItemTableViewCell", for: indexPath) as! BookItemTableViewCell
    
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
}

