//
//  MainViewController.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK: - MainViewController: UIViewController
class MainViewController: UIViewController {

  // MARK : - Property List
  @IBOutlet weak var tableView: UITableView!
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK : - View Life Cycle
  override func viewDidLoad() {

    super.viewDidLoad()
    setNavigationBarProperty()
    requestRssFeed()
  }

  private func requestRssFeed() {
    let url = Constants.APIRequest.BaseUrl + Constants.APIRequest.MoviesUrl
    RestClient.sharedInstance.requestNews(with: url) { (result, error) in

        guard error == nil else {
          return
        }

        print(result!)
    }
  }

  private func setNavigationBarProperty() {
    navigationController?.navigationBar.barTintColor = UIColor.black
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
  }
}

extension MainViewController: UITableViewDataSource {

  // MARK: - UITableViewDataSource Methods

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.News, for: indexPath)

    return cell
  }
}

extension UINavigationController {

  override open var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

}
