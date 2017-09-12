//
//  MainViewController.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SelectedIndex:Int

enum SelectedIndex: Int {
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
  fileprivate var isDataLoading: Bool = false
  fileprivate var inTheatersListPage = 1
  fileprivate var upcomingListPage = 1
  fileprivate var discoveredMovieList: [Movie] = [Movie]()
  fileprivate var inTheatersMovieList: [Movie] = [Movie]()
  fileprivate var upcomingMovieList: [Movie] = [Movie]()
  fileprivate var genreList: [Genre] = [Genre]()

  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    displayCollectionViewsBasedOnHiddenStatus(discoverIsHidden: false, genreListIsHidden: true, inTheatersIsHidden: true, upcomingListIsHidden: true)
    setNavigationBarColor()
    getDiscoverMovieList(page)
    addNotificationObserver()
  }

  // MARK : - Display CollectionViews

  private func displayCollectionViewsBasedOnHiddenStatus(discoverIsHidden: Bool,
                                                         genreListIsHidden: Bool,
                                                         inTheatersIsHidden: Bool,
                                                         upcomingListIsHidden: Bool) {

    inTheatersCollectionView.isHidden = inTheatersIsHidden
    upcomingCollectionView.isHidden = upcomingListIsHidden
    genreCollectionView.isHidden = genreListIsHidden
    discoverCollectionView.isHidden = discoverIsHidden

  }

  // MARK : - Add Observer 

  private func addNotificationObserver() {

    NotificationCenter.default.addObserver(self, selector: #selector(reloadGenreCollectionView),
                                           name: NSNotification.Name(rawValue: Constants.NotificationName.Genre), object: nil)

  }

  // MARK : - Reload Genre CollectionView

  func reloadGenreCollectionView() {

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    genreList = appDelegate.genreList
    genreCollectionView.reloadData()
  }

  // MARK : - Set NavigationBar Color 

  private func setNavigationBarColor() {
    navigationController?.navigationBar.barTintColor = UIColor.black
  }

  // MARK : - Action Method

  @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {

    switch sender.selectedSegmentIndex {

    case SelectedIndex.discover.rawValue:
      displayCollectionViewsBasedOnHiddenStatus(discoverIsHidden: false, genreListIsHidden: true, inTheatersIsHidden: true, upcomingListIsHidden: true)
      break
    case SelectedIndex.genres.rawValue:
      displayCollectionViewsBasedOnHiddenStatus(discoverIsHidden: true, genreListIsHidden: false, inTheatersIsHidden: true, upcomingListIsHidden: true)
      break
    case SelectedIndex.inTheaters.rawValue:
      displayCollectionViewsBasedOnHiddenStatus(discoverIsHidden: true, genreListIsHidden: true, inTheatersIsHidden: false, upcomingListIsHidden: true)
      fetchInTheatersMovieList()
      break
    case SelectedIndex.upcoming.rawValue:

      displayCollectionViewsBasedOnHiddenStatus(discoverIsHidden: true, genreListIsHidden: true, inTheatersIsHidden: true, upcomingListIsHidden: false)
      fetchUpcomingMovieList()
      break
    default:
      break
    }

  }

  // MARK : - Fetch Movie List 

  fileprivate func getDiscoverMovieList(_ page: Int) {

    Movie.discoveredMovieList(page: page) { (movieList, error) in

      guard error == nil else {
        #if DEBUG
          print(error!.localizedDescription)
        #endif
        return
      }

      guard let discoveredMovieList = movieList  else {
        return
      }
      self.discoveredMovieList.append(contentsOf: discoveredMovieList)
      DispatchQueue.main.async {
        self.discoverCollectionView.reloadData()
      }
    }

  }

  private func fetchInTheatersMovieList() {

    let method = Constants.API.Methods.MovieNowPlaying

    Movie.movieListWithMethod(method, page: 1, completionHandler: { (movieList, error) in

      guard error == nil else {
        #if DEBUG
          print(error!.localizedDescription)
        #endif
        return
      }

      guard let inTheatersMovieList = movieList else { return }

      self.inTheatersMovieList = inTheatersMovieList

      DispatchQueue.main.async {
        self.inTheatersCollectionView.reloadData()
      }

    })
  }

  private func fetchUpcomingMovieList() {

    let method = Constants.API.Methods.MovieUpcoming

    Movie.movieListWithMethod(method, page: 1, completionHandler: { (results, error) in

      guard error == nil else {
        #if DEBUG
          print(error!.localizedDescription)
        #endif
        return
      }

      guard let upcomingMovieList = results else { return }

      self.upcomingMovieList = upcomingMovieList
      DispatchQueue.main.async {
        self.upcomingCollectionView.reloadData()
      }
    })

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
        page += 1
        getDiscoverMovieList(page)
      }
    }
  }
}

// MARK : - MainViewController : UICollectionViewDelegateFlowLayout

extension MainViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout
                      collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == discoverCollectionView || collectionView == genreCollectionView {
      return CGSize(width: view.frame.size.width, height: Constants.CellConfiguration.DiscoverMovieCellHeight)
    } else {
      return CGSize(width: view.frame.size.width/Constants.CellConfiguration.NumberOfColumnsForUpcomingCV -
        Constants.CellConfiguration.NumberOfColumnsForUpcomingCV, height: Constants.CellConfiguration.UpcomingMovieCellHeight)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Constants.CellConfiguration.SectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.CellConfiguration.SectionInsets.top
  }
}
