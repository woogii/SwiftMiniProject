//
//  FlickrPictureViewController.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 12..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - FlickrPictureViewController: UICollectionViewController

class FlickrPictureViewController: UICollectionViewController {

  // MARK : - Property

  var photoInfoList = [PhotoInfo]()
  let refreshControl: UIRefreshControl = {
    let refreshControl  = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(FlickrPictureViewController.handleRefresh(_:)),
                             for: UIControlEvents.valueChanged)
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

  private func addRefreshControl() {

    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl = refreshControl
    } else {
      self.collectionView?.addSubview(refreshControl)
    }
  }

  // MARK : - End Refreshing

  private func stopRefreshControl() {

    if #available(iOS 10.0, *) {
      self.collectionView?.refreshControl?.endRefreshing()
    } else {
      self.refreshControl.endRefreshing()
    }
  }

  // MARK : - Action Method

  func handleRefresh(_ refreshControlForCollectionView: UIRefreshControl) {
    FlickrPictureViewController.page += 1
    getImageListFromFlickr(isRefreshing: true)
  }

  // MARK: Make Network Request

  private func getImageListFromFlickr(isRefreshing: Bool) {

    PhotoInfo.requestPhotoInfoList(currentPage: FlickrPictureViewController.page, completionHandler: { [weak self] results, error in

      guard error == nil else {
        #if DEBUG
          print("image request error..\(error!.localizedDescription)")
        #endif
        return
      }

      guard let returnedResult = results else {
        return
      }

      self?.photoInfoList = returnedResult

      DispatchQueue.main.async {
        self?.collectionView?.reloadData()

        if isRefreshing == true {
          self?.stopRefreshControl()
        }
      }
    })
  }

  // MARK : - CollectionView DataSource Methods

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCellIdentifier,
                                                for: indexPath) as? CustomCollectionViewCell else {
      return CustomCollectionViewCell()
    }
    cell.photoInfo = photoInfoList[indexPath.row]
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoInfoList.count
  }
}
