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
  
  @IBOutlet weak var discoverCollectionView: UICollectionView!
  @IBOutlet weak var inTheatersCollectionView: UICollectionView!
  fileprivate var page = 1
  fileprivate var inTheatersListPage = 1
  fileprivate var discoveredMovieList:[Movie] = [Movie]()
  fileprivate var inTheatersMovieList:[Movie] = [Movie]()
  fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    inTheatersCollectionView.isHidden = true
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
          return nil
        }
      })
      
    
      self.discoveredMovieList.append(contentsOf: fetchedDiscoveredList)
      
      #if DEBUG
        print("Discovered list count : \(self.discoveredMovieList.count)")
      #endif 
      
      DispatchQueue.main.async() {
        self.discoverCollectionView.reloadData()
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
      
      discoverCollectionView.isHidden = true
      inTheatersCollectionView.isHidden = false
      
      RestClient.sharedInstance.requestMovieListInTheaters(page: 1, completionHandler: { (results, error) in
        
        if let error = error {
          print(error.localizedDescription)
        } else {
          
          guard let dictionaryArray = results?["results"] as? [[String:Any]] else {
            return
          }
          
          self.inTheatersMovieList = dictionaryArray.flatMap({ dict -> Movie? in
            do {
              return try Movie(dictionary: dict)
            } catch let error {
              print(error.localizedDescription)
              return nil
            }
          })
          
          DispatchQueue.main.async {
            self.inTheatersCollectionView.reloadData()
          }
          
          print(self.inTheatersMovieList)
        }
        
      })
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
    if collectionView == discoverCollectionView {
      return discoveredMovieList.count
    } else if collectionView == inTheatersCollectionView {
      return inTheatersMovieList.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == discoverCollectionView {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.DiscoveredMovie, for: indexPath) as! DiscoveredMovieCollectionViewCell
      cell.movieInfo = discoveredMovieList[indexPath.row]
      return cell
    } else if collectionView == inTheatersCollectionView {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.InTheatersMovie, for: indexPath) as! InTheatersMovieCollectionViewCell
      cell.movieInfo = inTheatersMovieList[indexPath.row]
      return cell
    } else {
      return UICollectionViewCell()
    }
    
  }
  
}

// MARK : - MainViewController : UIScrollViewDelegate

extension MainViewController : UIScrollViewDelegate {

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
   
    let scrollViewHeight = scrollView.frame.size.height
  
    if scrollView == discoverCollectionView {
      
      if scrollView.contentSize.height <= scrollView.contentOffset.y + scrollViewHeight {
        page = page + 1
        getDiscoverMovieList(page)
      }
      
    }
  }
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == discoverCollectionView {
      return CGSize(width: view.frame.size.width , height: 140)
    } else {
      return CGSize(width: view.frame.size.width/3 - 4, height: 160)
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.top
  }
}

