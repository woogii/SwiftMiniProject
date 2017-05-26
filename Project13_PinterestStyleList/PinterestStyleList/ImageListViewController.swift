//
//  ImageListViewController.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ImageListViewController: UICollectionViewController

class ImageListViewController: UICollectionViewController {
  
  // MARK : - Property
  
  var posts = [PostInfo]()
  var isRequesting = false
  var isLastPage = false
  let refreshControl : UIRefreshControl = {
    let refreshControl  = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ImageListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  let RFC3339DateFormatter : DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.locale = Locale(identifier: Constants.ImageListVC.USPosixLocale)
    dateFormater.dateFormat = Constants.ImageListVC.JsonDateFormat
    dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
    return dateFormater
  }()
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addRefreshControl()
    loadDataFromBundle()
  }
  
  func addRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl = refreshControl
    } else {
      self.collectionView?.addSubview(refreshControl)
    }
    
  }
  
  // MARK : - Action Method
  
  func handleRefresh(_ refreshControlForCollectionView:UIRefreshControl) {
    initList()
    loadDataFromBundle()
  }
  
  // MARK : - Initialize CollectionView DataSource
  
  func initList() {
    posts = []
  }
  
  // MARK : - Load JSON
  
  func loadDataFromBundle() {
    
    if let pathUrl = Bundle.main.url(forResource: Constants.ImageListVC.BundleResourceName, withExtension: "json") {
      
      do {
        
        let data = try Data(contentsOf: pathUrl)
        
        if let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] {
          
          posts = dictionaryArray.flatMap(PostInfo.init)
        
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
          }
        }
      } catch let err {
        #if DEBUG
          print(err)
        #endif
      }
      
    }
    
  }
  
  // MARK : - End Refreshing
  
  func stopRefreshControl() {
    
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl?.endRefreshing()
    } else {
      self.refreshControl.endRefreshing()
    }
    
  }
  
  // MARK : - UICollectionView DataSource Methods
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ImageListCollectionViewCell.Identifier, for: indexPath) as! ImageListCollectionViewCell
    
    configureImageListCollectionViewCell(cell: cell, indexPath:indexPath)
    
    return cell
  }
  
  // MARK : - Configure CollectionViewcell
  
  func configureImageListCollectionViewCell(cell:ImageListCollectionViewCell, indexPath:IndexPath) {
    
    var post = posts[indexPath.row]
    
    var bgImage:UIImage? =  nil
    var profileImage:UIImage? = nil
    
    cell.backgroundImageView.image = nil
    cell.profileImageView.image = nil
    
    
    if post.backgroundImage != nil && post.profileImage != nil {
      bgImage = post.backgroundImage
      profileImage = post.profileImage
    } else {
      
      let bgImageRequestTask = RestClient.sharedInstance.fetchImageList(urlString: post.backgroundImageUrlString!, size: Constants.Public.DefaultListSize, completionHandler: { (result,error) in
        
        if error != nil {
          
        } else {
          
          if let data = result as? Data {
            
            let backgroundImage = UIImage(data:data)
            post.backgroundImage = backgroundImage
            
            let profileImageRequestTask = RestClient.sharedInstance.fetchImageList(urlString: post.profileImageUrlString!, size: Constants.Public.DefaultListSize, completionHandler: { (result,error) in
              
              if let data = result as? Data {
                
                let profileImage = UIImage(data: data)
                
                post.profileImage = profileImage
                
                UIView.transition(with: cell.backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                  
                  DispatchQueue.main.async {
                    cell.backgroundImageView.image = backgroundImage
                    cell.profileImageView.image = profileImage
                  }
                  
                }, completion: nil)
                
              }
              
            })
            cell.taskToCancelifCellIsReused = profileImageRequestTask
          }
        }
      })
      
      cell.taskToCancelifCellIsReused = bgImageRequestTask
      
    }
    
    cell.creatorLabel.text = post.userName
    cell.numberOfLikesLabel.text = String(post.numberOfLikes ?? 0)
    cell.backgroundImageView.image = bgImage
    cell.profileImageView.image = profileImage
    cell.timeInfoLabel.text = RFC3339DateFormatter.date(from:post.timeInfo ?? "")?.timeAgoDisplay()
    
  }
  
  // MARK: - UIScrollViewDelegate
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    stopRefreshControl()
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if scrollView.contentSize.height > scrollView.frame.size.height {
      
      if scrollView.bounds.origin.y + scrollView.frame.size.height >= scrollView.contentSize.height {
        
        if !isRequesting && !isLastPage {
          
          isRequesting = true
          loadMoreImageList()
        }
      }
    }
  }
  
  // MARK : - Load More List
  
  func loadMoreImageList() {
    
    if let path = Bundle.main.path(forResource: Constants.ImageListVC.BundleResourceName, ofType: Constants.ImageListVC.FileTypeJSON) {
      
      do {
        
        let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        
        if let dictionaryArray = try(JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] {
          
          
          let addedPosts = dictionaryArray.flatMap(PostInfo.init)
          
          if addedPosts.count == 0 {
            self.isLastPage = true
            return
          }
          
          self.posts.append(contentsOf: addedPosts)
          
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.isRequesting = false
          }
          
        }
      } catch let err {
        #if DEBUG
          print(err)
        #endif
      }
    }
  }
}

// MARK : - ImageListViewController: UICollectionViewDelegateFlowLayout

extension ImageListViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.size.width/Constants.ImageListVC.NumberOfColumns, height: Constants.ImageListCollectionViewCell.ImageListCollectionViewCelllHeight)
    
  }
  
}

// MARK : - Date Extension

extension Date {
  
  func timeAgoDisplay()-> String {
    
    let secondsAgo = Int(Date().timeIntervalSince(self))
    
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    
    if secondsAgo < minute {
      return "\(secondsAgo) seconds ago"
    } else if secondsAgo < hour {
      return "\(secondsAgo/minute) minutes ago"
    } else if secondsAgo < day {
      return "\(secondsAgo/hour) hours ago"
    } else if secondsAgo < week {
      return "\(secondsAgo/day) days ago"
    }
    
    return "\(secondsAgo/week) weeks ago"
  }
  
}






