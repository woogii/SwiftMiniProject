//
//  ViewController.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 12..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit


// MARK : - ViewController: UICollectionViewController

class ViewController: UICollectionViewController {

  // MARK : - Property
  
  var photoInfoList = [PhotoInfo]()
  var sharedSession : URLSession {
    return URLSession.shared
  }
  let refreshControl : UIRefreshControl = {
    let refreshControl  = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  static var page = 1
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {

    super.viewDidLoad()
    PhotoInfo.requestPhotoInfoList(currentPage: ViewController.page, completionHandler: { results, error in
      
    })
    
    //addRefreshControl()
    //getImageListFromFlickr(isRefreshing: false)
  }
  
  // MARK : - Add Refresh Control
  
  func addRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl = refreshControl
    } else {
      self.collectionView?.addSubview(refreshControl)
    }
    
  }
  
  // MARK : - Action Method
  
  func handleRefresh(_ refreshControlForCollectionView:UIRefreshControl) {
    ViewController.page += 1
    getImageListFromFlickr(isRefreshing: true)
  }
  
  
  // MARK : - Set API Parameters
  
  func setParameters()->[String:String]{
    return [
      Constants.FlickrParameterKeys.Method  : Constants.FlickrParameterValues.RecentPhotosMethod,
      Constants.FlickrParameterKeys.APIKey  : Secret.APIKey,
      Constants.FlickrParameterKeys.Extras  : Constants.FlickrParameterValues.MediumURL,
      Constants.FlickrParameterKeys.Format  : Constants.FlickrParameterValues.ResponseFormat,
      Constants.FlickrParameterKeys.PerPage : Constants.FlickrParameterValues.NumberOfItems,
      Constants.FlickrParameterKeys.Page    : String(ViewController.page),
      Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
    ]
  }
  
  // MARK: Make Network Request
  
  private func getImageListFromFlickr(isRefreshing:Bool) {
    
  }

  // MARK : - CollectionView DataSource Methods
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCellIdentifier, for: indexPath) as! CustomCollectionViewCell
    cell.photoInfo = photoInfoList[indexPath.row]
    return cell
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoInfoList.count
  }
  
  // MARK: - UIScrollViewDelegate
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
  }
  
  // MARK : - End Refreshing
  
  private func stopRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl?.endRefreshing()
    } else {
      self.refreshControl.endRefreshing()
    }
    
  }
  
}


