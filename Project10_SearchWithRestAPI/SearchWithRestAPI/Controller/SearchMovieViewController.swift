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
  var searchedMovieList = [Movie]()
  var upcomingMovieList = [Movie]()

  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()
    fetchMovieListWith(keyword: nil)
  }
  // MARK : - Fetch Upcoming Movie List
  fileprivate func fetchMovieListWith(keyword: String?) {
    Movie.requestMovieList(searchKeyword: keyword) { (movieList, error) in
      guard error == nil else {
        #if DEBUG
          print(error!.localizedDescription)
        #endif
        return
      }
      guard let unwrappedMovieList = movieList else {
        return
      }
      if let _ = keyword {
        self.searchedMovieList = unwrappedMovieList
      } else {
        self.upcomingMovieList = unwrappedMovieList
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  // MARK : - Configure UISearchController
  private func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  fileprivate func resetSearchController() {
    searchedMovieList = []
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

// MARK : - SearchMovieViewController : UISearchResultsUpdating

extension SearchMovieViewController : UISearchResultsUpdating {

  // MARK : - UISearchController Delegate Method
  func updateSearchResults(for searchController: UISearchController) {
    if !searchController.isActive { // if the cancle button is tapped
      resetSearchController()
    } else {
      fetchMovieListWith(keyword: searchController.searchBar.text ?? "")
    }
  }
}

// MARK : - SearchMovieViewController : UITableViewDataSource

extension SearchMovieViewController : UITableViewDataSource {
  // MARK : - UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive && searchController.searchBar.text != "" {
      return searchedMovieList.count
    }
    return upcomingMovieList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.MovieTitleCell, for: indexPath)
    if searchController.isActive && searchController.searchBar.text != "" {
      cell.textLabel?.text = searchedMovieList[indexPath.row].title
    } else {
      cell.textLabel?.text = upcomingMovieList[indexPath.row].title
    }
    return cell
  }
}
