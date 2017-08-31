//
//  SearchMovieViewController.swift
//  SearchWithRestAPI
//
//  Created by siwook on 2017. 5. 16..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SearchMovieViewController : UIViewController

class SearchMovieViewController: UIViewController {

  // MARK : - Property
  
  @IBOutlet weak var tableView: UITableView!
  let searchController = UISearchController(searchResultsController: nil)
  
  var session : URLSession {
    return URLSession.shared
  }
  var titleList = [String]()
  var upcomingList = [String]()

  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSearchController()
    Movie.requestUpcomingMovieList { (movieTitleList, error) in
      
    }
  }

  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  
  func performSearch(keyword :String) {
    
  }

}

// MARK : - SearchMovieViewController : UISearchResultsUpdating

extension SearchMovieViewController : UISearchResultsUpdating {

  // MARK : - UISearchController Delegate Method
  
  func updateSearchResults(for searchController: UISearchController) {
    
    performSearch(keyword: searchController.searchBar.text ?? "")
  }
  
}

// MARK : - SearchMovieViewController : UITableViewDataSource

extension SearchMovieViewController : UITableViewDataSource {
  
  // MARK : - UITableViewDataSource Methods
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive && searchController.searchBar.text != "" {
      return titleList.count
    }
    return upcomingList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    if searchController.isActive && searchController.searchBar.text != "" {
      cell.textLabel?.text = titleList[indexPath.row]
    } else {
      cell.textLabel?.text = upcomingList[indexPath.row]
    }
  
    return cell
  }
}
