//
//  ViewController.swift
//  Project09_ToDoList
//
//  Created by siwook on 2017. 5. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    configureTableView()
  }
  
  func configureTableView() {
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }

}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return UITableViewCell()
  }
}

