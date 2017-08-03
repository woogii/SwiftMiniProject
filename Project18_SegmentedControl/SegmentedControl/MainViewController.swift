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
  
  @IBOutlet weak var genreCollectionView: UICollectionView!
  @IBOutlet weak var upcomingCollectionView: UICollectionView!
  @IBOutlet weak var discoverCollectionView: UICollectionView!
  @IBOutlet weak var inTheatersCollectionView: UICollectionView!
  fileprivate var page = 1
  fileprivate var inTheatersListPage = 1
  fileprivate var upcomingListPage = 1
  fileprivate var discoveredMovieList:[Movie] = [Movie]()
  fileprivate var inTheatersMovieList:[Movie] = [Movie]()
  fileprivate var upcomingMovieList:[Movie] = [Movie]()
  fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
  fileprivate let numberOfColumnsForUpcomingCV:CGFloat = 3
  fileprivate let minimumSpacingForUpcomingCell:CGFloat = 3
  fileprivate let discoverMovieCellHeight:CGFloat = 140
  fileprivate let upcomingMovieCellHeight:CGFloat = 160
  fileprivate var genreList:[Genre] = [Genre]()
  
//  fileprivate let genreList:[Genre] = {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let genreList = appDelegate.genreList
//    return genreList
//  }()
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    inTheatersCollectionView.isHidden = true
    upcomingCollectionView.isHidden = true
    genreCollectionView.isHidden = true
    
    setNavigationBarColor()
    getDiscoverMovieList(page)
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(reloadGenreCollectionView), name: NSNotification.Name(rawValue: "genre"), object: nil)
  }
  
  func reloadGenreCollectionView() {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    genreList = appDelegate.genreList
    genreCollectionView.reloadData()
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
        //print("Discovered list count : \(self.discoveredMovieList.count)")
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
      discoverCollectionView.isHidden = false
      inTheatersCollectionView.isHidden = true
      upcomingCollectionView.isHidden = true
      genreCollectionView.isHidden = true
      break
    case SelectedIndex.genres.rawValue:
      
      discoverCollectionView.isHidden = true
      inTheatersCollectionView.isHidden = true
      upcomingCollectionView.isHidden = true
      genreCollectionView.isHidden = false
      break
      
    case SelectedIndex.inTheaters.rawValue:
      
      discoverCollectionView.isHidden = true
      inTheatersCollectionView.isHidden = false
      upcomingCollectionView.isHidden = true
      genreCollectionView.isHidden = true
      
      let method = Constants.API.Methods.MovieNowPlaying
      
      RestClient.sharedInstance.requestMovieListBasedOnUserSelection(method: method, page: 1, completionHandler: { (results, error) in
        
        if let error = error {
          print(error.localizedDescription)
        } else {
          
          guard let dictionaryArray = results?[Constants.JSONParsingKeys.Results] as? [[String:Any]] else {
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
          
          //print(self.inTheatersMovieList)
        }
        
      })
      break
    case SelectedIndex.upcoming.rawValue:
      
      discoverCollectionView.isHidden = true
      inTheatersCollectionView.isHidden = true
      upcomingCollectionView.isHidden = false
      genreCollectionView.isHidden = true
      
      let method = Constants.API.Methods.MovieUpcoming

      RestClient.sharedInstance.requestMovieListBasedOnUserSelection(method: method, page: 1, completionHandler: { (results, error) in
        
        if let error = error {
          print(error.localizedDescription)
        } else {
          
          guard let dictionaryArray = results?[Constants.JSONParsingKeys.Results] as? [[String:Any]] else {
            return
          }
          
          self.upcomingMovieList = dictionaryArray.flatMap({ dict -> Movie? in
            do {
              return try Movie(dictionary: dict)
            } catch let error {
              print(error.localizedDescription)
              return nil
            }
          })
          
          DispatchQueue.main.async {
            self.upcomingCollectionView.reloadData()
          }
          
          print(self.upcomingMovieList)
        }
        
      })
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
    } else if collectionView == upcomingCollectionView {
      return upcomingMovieList.count
    } else if collectionView == genreCollectionView {
      return genreList.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == discoverCollectionView {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.DiscoveredMovie, for: indexPath) as! DiscoveredMovieCollectionViewCell
      cell.movieInfo = discoveredMovieList[indexPath.row]
      return cell
      
    } else if collectionView == genreCollectionView {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.Genre, for: indexPath) as! GenreCollectionViewCell
      cell.genreInfo = genreList[indexPath.row]
      return cell
    } else if collectionView == inTheatersCollectionView {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.InTheatersMovie, for: indexPath) as! InTheatersMovieCollectionViewCell
      cell.movieInfo = inTheatersMovieList[indexPath.row]
      return cell
      
    } else if collectionView == upcomingCollectionView {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CollectionView.InTheatersMovie, for: indexPath) as! InTheatersMovieCollectionViewCell
      cell.movieInfo = upcomingMovieList[indexPath.row]
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
    if collectionView == discoverCollectionView || collectionView == genreCollectionView {
      return CGSize(width: view.frame.size.width , height: discoverMovieCellHeight)
    } else {
      return CGSize(width: view.frame.size.width/numberOfColumnsForUpcomingCV - numberOfColumnsForUpcomingCV, height: upcomingMovieCellHeight)
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.top
  }
}

