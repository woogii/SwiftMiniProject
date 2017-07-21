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
    addRefreshControl()
    getImageListFromFlickr(isRefreshing: false)
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
    
    let methodParameters = setParameters()
    
    let escapedParameters = Helper.escapedParameters(methodParameters as [String : AnyObject])
    let urlString = Constants.Flickr.APIBaseURL + escapedParameters
    
    print("page : \(ViewController.page)")
    print("escaped parameters : \(escapedParameters)")
    let url = URL(string: urlString)!
    let request = URLRequest(url: url)
    
    let task = sharedSession.dataTask(with: request) { (data, response, error) in
      
      // if an error occurs, print it and re-enable the UI
      func displayError(_ error: String) {
        print(error)
        print("URL at time of error: \(url)")
      }
      
      guard (error == nil) else {
        displayError("There was an error with your request: \(error!.localizedDescription)")
        return
      }
      
      guard let data = data else {
        displayError("No data was returned by the request!")
        return
      }
      
      // parse the data
      let parsedResult: [String:AnyObject]!
      do {
        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
        // print("result : \(parsedResult)")
      } catch {
        displayError("Could not parse the data as JSON: '\(data)'")
        return
      }
      
      /* GUARD: Did Flickr return an error (stat != ok)? */
      guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String, stat == Constants.FlickrResponseValues.OKStatus else {
        displayError("Flickr API returned an error. See error code and message in \(parsedResult)")
        return
      }
      
      /* GUARD: Are the "photos" and "photo" keys in our result? */
      guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject], let photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] else {
        displayError("Cannot find keys '\(Constants.FlickrResponseKeys.Photos)' and '\(Constants.FlickrResponseKeys.Photo)' in \(parsedResult)")
        return
      }
      
      if isRefreshing == true {
        self.photoInfoList = []
      }
      
      self.photoInfoList = PhotoInfo.createPhotoInfoList(photoInfoDictionaryArray: photoArray)
      
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
        self.stopRefreshControl()
      }
    
    }
    task.resume()
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
  
  func stopRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl?.endRefreshing()
    } else {
      self.refreshControl.endRefreshing()
    }
    
  }
  
}


