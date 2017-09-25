//
//  SearchBookController.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SearchBookViewController: UIViewController

class SearchBookViewController: UIViewController {

  // MARK : - Property 

  @IBOutlet weak var tableView: UITableView!
  fileprivate let searchController = UISearchController(searchResultsController: nil)

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()

  }

  override func viewDidAppear(_ animated: Bool) {

    super.viewDidAppear(animated)
    delay(0.1) { self.searchController.searchBar.becomeFirstResponder() }

  }

  private func delay(_ delay: Double, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
  }

  func configureSearchController() {

    searchController.searchBar.delegate = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchBar.barTintColor = UIColor.black.withAlphaComponent(0.8)

    setSearchBarCancelButtonColor()
    setSearchBarBackgroundColor()

  }

  private func setSearchBarCancelButtonColor() {
    let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.lightGray]
    UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject],
                                                        for: UIControlState.normal)
  }

  private func setSearchBarBackgroundColor() {

    for subView in searchController.searchBar.subviews {
      for subView1 in subView.subviews {
        if subView1 is UITextField {
          subView1.backgroundColor = UIColor.darkGray
        }
      }
    }

  }
}

extension SearchBookViewController : UISearchBarDelegate {

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension SearchBookViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}
