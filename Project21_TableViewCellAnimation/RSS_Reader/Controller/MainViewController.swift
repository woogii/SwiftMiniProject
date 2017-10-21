//
//  MainViewController.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - MainViewController: UIViewController

class MainViewController: UIViewController {

  // MARK : - Properties
  @IBOutlet weak var tableView: UITableView!

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK : - View Life Cycle

  override func viewDidLoad() {

    super.viewDidLoad()
    navigationController?.navigationBar.barTintColor = UIColor.black
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    RestClient.sharedInstance.requestNews(with: "techCrunch") { (result, error) in

      guard error == nil else {
        return
      }

      print(result!)
    }
  }
}

extension MainViewController: UITableViewDataSource {

  // MARK : - UITableViewDataSource Methods

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.NewsCell, for: indexPath)

    return cell
  }
}

extension UINavigationController {

  override open var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

}
