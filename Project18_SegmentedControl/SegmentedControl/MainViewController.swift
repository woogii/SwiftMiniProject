//
//  MainViewController.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SelectedIndex:Int 

enum SelectedIndex:Int {
  case discover = 0, genres, inTheaters, upcoming
}

//  MARK : - MainViewController: UIViewController

class MainViewController: UIViewController {
  
  // MARK : - Property
  
  @IBOutlet weak var collectionView: UICollectionView!
  fileprivate var page = 1
  fileprivate var discoveredMovieList:[Movie] = [Movie]()
  fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationBarColor()
    getDiscoverMovieList(page)
  }
  
  func getDiscoverMovieList(_ page:Int) {
    
    
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
      
      let fetchedDiscoveredList = dictArray.flatMap({ dict -> Movie? in
        do {
          return try Movie(dictionary: dict)
        } catch let error {
          print(error.localizedDescription)
          return Movie()
        }
      })
      
    
      self.discoveredMovieList.append(contentsOf: fetchedDiscoveredList)
     
      print("Discovered list count : \(self.discoveredMovieList.count)")
      
      DispatchQueue.main.async() {
        self.collectionView.reloadData()
      }
    }
    
  }
  
  func setNavigationBarColor() {
    navigationController?.navigationBar.barTintColor = UIColor.black
  }
  
  @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
      
    case SelectedIndex.discover.rawValue:
      
      break
    case SelectedIndex.genres.rawValue:
      
      break
    case SelectedIndex.inTheaters.rawValue:
      
      break
    case SelectedIndex.upcoming.rawValue:
      
      break
      
    default:
      break
    }
    
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

// MARK : - MainViewController : UIScrollViewDelegate

extension MainViewController : UIScrollViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
   
    let scrollViewHeight = scrollView.frame.size.height
  
    if scrollView.contentSize.height <= scrollView.contentOffset.y + scrollViewHeight {
      page = page + 1
      getDiscoverMovieList(page)
    }
    
  }
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.size.width , height: 140)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.top
  }
}

