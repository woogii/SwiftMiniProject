//
//  ViewController.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 6. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Foundation
import LGSideMenuController

// MARK : - BookListViewController : UIViewController

class BookListViewController: UIViewController {

  // MARK : - Property 

  @IBOutlet weak var tableView: UITableView!
  fileprivate var bookList = [Book]()

  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    fetchBookInfo()
    setNavigationBarProperty()
    changeStatusBarColor()

  }

  private func setNavigationBarProperty() {
    navigationController?.navigationBar.barTintColor = UIColor.black
    navigationController?.navigationBar.isTranslucent = true
    let navigationBackgroundView = self.navigationController?.navigationBar.subviews.first
    navigationBackgroundView?.alpha = 0.8
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

  }

  private func changeStatusBarColor() {
   navigationController?.navigationBar.barStyle = .black
  }

  private func fetchBookInfo() {

    guard let bookListJSONUrl = Bundle.main.url(forResource: Constants.BookListJSONFileName,
                                                withExtension: Constants.BookListJSONFileType) else {
      return
    }

    do {
      let bookListData = try Data(contentsOf: bookListJSONUrl)

      guard let bookListDictArray =
        try JSONSerialization.jsonObject(with: bookListData,
                                         options: .allowFragments) as? [[String:Any]] else {
        return
      }

      bookList = bookListDictArray.flatMap {
        return Book(dictionary: $0)
      }

    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }

  @IBAction func tappedSideMenuButton(_ sender: UIBarButtonItem) {
  }

  @IBAction func segmentIndexChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {

    case 0 :

      break
    case 1:

      break
    default:
      break
    }
  }
}

// MARK : - BookListViewController : UITableViewDataSource

extension BookListViewController : UITableViewDataSource {

  // MARK : - TableView DataSource Methods
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.BookItemTableViewCell,
                                                   for: indexPath) as? BookItemTableViewCell else {
      return BookItemTableViewCell()
    }
    cell.bookItemInfo = bookList[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookList.count
  }
}
