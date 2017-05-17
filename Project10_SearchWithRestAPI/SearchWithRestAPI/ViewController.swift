//
//  ViewController.swift
//  SearchWithRestAPI
//
//  Created by siwook on 2017. 5. 16..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  let searchController = UISearchController(searchResultsController: nil)
  
  var session : URLSession {
    return URLSession.shared
  }
  var titleList = [String]()
  var upcomingList = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSearchController()
    fetchUpcomingList()
  }

  func fetchUpcomingList() {
   
    let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Constants.TMDBParameterValues.ApiKey)&language=en-US&page=1&region=us"
    let url = URL(string: urlString)!
    
    URLSession.shared.dataTask(with: url, completionHandler:{ (data, response, error) in
      
      if let error = error {
        print(error)
      } else {
        
        var parsedResult:[String:AnyObject]!
        do {
          
          parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
          
          if let resultArry = parsedResult["results"] as? [[String:AnyObject]] {
            
            self.upcomingList = resultArry.map({
              return ($0["title"] as? String ?? "")
            })
          }
          
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
          
        } catch let error {
          print(error)
        }
      }
      
    }).resume()
    
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  
  

}

extension ViewController : UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    
    performSearch(keyword: searchController.searchBar.text ?? "")
  }
  
  func performSearch(keyword :String) {
    
    let optionalUrl = createURLWithKeyword(keyword: keyword)
    
    guard let url = optionalUrl else {
      return
    }
    
    session.dataTask(with: url, completionHandler:{ (data, response, error) in
      
      if let error = error {
        print(error)
      } else {
        
        var parsedResult:[String:AnyObject]!
        do {
          
          parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
        
          if let resultArry = parsedResult["results"] as? [[String:AnyObject]] {
            
            self.titleList = resultArry.map({
              return ($0["title"] as? String ?? "")
            })
          } 
          
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
          
        } catch let error {
          print(error)
        }
      }
      
    }).resume()
    
  }
  
  func createURLWithKeyword(keyword:String)-> URL? {
    
    var urlComponents = URLComponents()
    
    urlComponents.scheme = Constants.TMDB.ApiScheme
    urlComponents.host   = Constants.TMDB.ApiHost
    urlComponents.path   = Constants.TMDB.ApiPathForSearch
    
    let apiQuery = URLQueryItem(name: Constants.TMDBParameterKeys.ApiKey, value: Constants.TMDBParameterValues.ApiKey)
    let searchQuery = URLQueryItem(name: Constants.TMDBParameterKeys.SearchKeyword, value: keyword)
    urlComponents.queryItems = [apiQuery, searchQuery]
    
    return urlComponents.url
  }
  
}

extension ViewController : UITableViewDataSource {
  
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
