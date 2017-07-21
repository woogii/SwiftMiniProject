//
//  MainViewController.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

//  MARK : - MainViewController: UIViewController

class MainViewController: UIViewController {

  // MARK : - Property
  
  @IBOutlet weak var collectionView: UICollectionView!
  var page = 1
  var discoveredMovieList:[Movie] = [Movie]()
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionViewLayout()
    setNavigationBarColor()
    getDiscoverMovieList()
    
  }
    
  func configureCollectionViewLayout() {
  
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 140.0)
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.minimumLineSpacing = 0
    flowLayout.scrollDirection = .vertical
  }
  
  func getDiscoverMovieList() {
    
    RestClient.sharedInstance.requestDiscoverMovieList(page: page) { (result, error) in
      
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      
      guard let jsonResult = result else {
        return
      }
      
      guard let dictArray = jsonResult[Constants.JSONParsingKeys.Results] as? [[String:Any]] else {
        return
      }
      
      self.discoveredMovieList = dictArray.flatMap({ dict -> Movie? in
        do {
          return try Movie(dictionary: dict)
        } catch let error {
          print(error.localizedDescription)
          return Movie()
        }
      })
      
      DispatchQueue.main.async() {
        self.collectionView.reloadData()
      }
      
      
    }
    
    
    
  }
  
  func setNavigationBarColor() {
    navigationController?.navigationBar.barTintColor = UIColor.black
  }
  
}

// MARK : - MainViewController : UICollectionViewDataSource, UICollectionViewDelegate

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
  
  // MARK : - UITableViewDataSource Methods
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return discoveredMovieList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.DiscoveredMovie, for: indexPath) as! DiscoveredMovieCollectionViewCell
    
    cell.movieInfo = discoveredMovieList[indexPath.row]
    
    return cell
  }
}

