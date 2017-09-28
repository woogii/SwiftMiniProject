//
//  ImageListViewController.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

// MARK : - ImageListViewController: UICollectionViewController
class ImageListViewController: UICollectionViewController {
  // MARK : - Property
  var posts = [PostInfo]()
  var isRequesting = false
  var isLastPage = false
  let refreshControl: UIRefreshControl = {
    let refreshControl  = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ImageListViewController.handleRefresh(_:)),
                             for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  let RFC3339DateFormatter: DateFormatter = {
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
    collectionView?.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    if let layout = collectionView?.collectionViewLayout as? CustomCollectionViewLayout {
      layout.delegate = self
    }
  }
  func addRefreshControl() {
    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl = refreshControl
    } else {
      self.collectionView?.addSubview(refreshControl)
    }
  }
  // MARK : - Action Method
  func handleRefresh(_ refreshControlForCollectionView: UIRefreshControl) {
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
        if let dictionaryArray = try(JSONSerialization
                                      .jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] {
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
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
                      .dequeueReusableCell(withReuseIdentifier: Constants.ImageListCollectionViewCell.Identifier,
                                           for: indexPath) as? ImageListCollectionViewCell else {
                                            return ImageListCollectionViewCell()
    }
    configureImageListCollectionViewCell(cell: cell, indexPath:indexPath)
    return cell
  }
  // MARK : - Configure CollectionViewcell
  func configureImageListCollectionViewCell(cell: ImageListCollectionViewCell,
                                            indexPath: IndexPath) {
    var post = posts[indexPath.row]
    cell.backgroundImageView.image = nil
    cell.profileImageView.image = nil
    if post.backgroundImage != nil && post.profileImage != nil {
      cell.backgroundImageView.image = post.backgroundImage
      cell.profileImageView.image = post.profileImage
    } else {
        _  = RestClient.sharedInstance.fetchImageList(urlString: post.backgroundImageUrlString!,
                                                      size: Constants.Public.DefaultListSize,
                                                      completionHandler: { (result, error) in
        if error != nil {
          #if DEBUG
            print("background Image request error..\(error!.localizedDescription))")
          #endif
        } else {
          if let data = result as? Data {
            let backgroundImage = UIImage(data:data)
            post.backgroundImage = backgroundImage
            _ = RestClient.sharedInstance.fetchImageList(urlString: post.profileImageUrlString!,
                                                         size: Constants.Public.DefaultListSize,
                                                         completionHandler: { (result, error) in
              if let data = result as? Data {
                let profileImage = UIImage(data: data)
                post.profileImage = profileImage
                UIView.transition(with: cell.backgroundImageView, duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                  DispatchQueue.main.async {
                    if let updateCell = self.collectionView?
                                              .cellForItem(at: indexPath) as? ImageListCollectionViewCell {
                      updateCell.backgroundImageView.image = backgroundImage
                      updateCell.profileImageView.image = profileImage
                    }
                  }
                }, completion: nil)
              } else {
                #if DEBUG
                  print("background Image request error..\(error!.localizedDescription))")
                #endif
              }
            })
          }
        }
      })
    }
    cell.creatorLabel.text = post.userName
    cell.numberOfLikesLabel.text = String(post.numberOfLikes ?? 0)
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
    if let path = Bundle.main.path(forResource: Constants.ImageListVC.BundleResourceName,
                                   ofType: Constants.ImageListVC.FileTypeJSON) {
      do {
        let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        if let dictionaryArray = try(JSONSerialization.jsonObject(with: data,
                                                                  options: .allowFragments)) as? [[String: Any]] {
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
// MARK : - ImageListViewController : CustomLayoutDelegate
extension ImageListViewController: CustomLayoutDelegate {

  func collectionView(collectionView: UICollectionView,
                      heightForPhotoAt indexPath: IndexPath,
                      with width: CGFloat) -> CGFloat {
    let post = posts[indexPath.item]
    let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
    if let image = post.backgroundImage {
      let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
      return rect.size.height
    }
    return 0
  }
  func collectionView(collectionView: UICollectionView,
                      heightForCaptionAt indexPath: IndexPath,
                      with width: CGFloat) -> CGFloat {
    let profileImageTopPadding = CGFloat(10)
    let profileImageHeight = CGFloat(24)
    let profileImageBottomPadding = CGFloat(5)
    let separatorViewHeight = CGFloat(1)
    let likeImageTopPadding = CGFloat(12)
    let likeImageHeight = CGFloat(14)
    let likeImageBottomPadding = CGFloat(13)
    let height = profileImageTopPadding + profileImageHeight + profileImageBottomPadding
      + separatorViewHeight + likeImageTopPadding + likeImageHeight
      + likeImageBottomPadding
    return height
  }
}
