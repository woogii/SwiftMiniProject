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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    configureSearchController()
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
    print("keyword : \(keyword)")
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
          // print("parsedResult : \(parsedResult)")
          if let resultArry = parsedResult["results"] as? [[String:AnyObject]] {
            
            self.titleList = resultArry.map({
              return ($0["title"] as? String ?? "")
            })
            
            print(self.titleList)
            
          } else {
            self.titleList = []
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
    urlComponents.path   = Constants.TMDB.ApiPath
    
    let apiQuery = URLQueryItem(name: Constants.TMDBParameterKeys.ApiKey, value: Constants.TMDBParameterValues.ApiKey)
    let searchQuery = URLQueryItem(name: Constants.TMDBParameterKeys.SearchKeyword, value: keyword)
    urlComponents.queryItems = [apiQuery, searchQuery]
    
    return urlComponents.url
  }
  
}

extension ViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titleList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = titleList[indexPath.row]
    
    return cell
  }
}
