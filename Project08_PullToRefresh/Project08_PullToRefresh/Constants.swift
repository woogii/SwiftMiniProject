//
//  Constants.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - Constants

struct Constants {
  
  static let CollectionViewCellIdentifier = "customCollectionViewCell"
  
  // MARK: Flickr
  struct Flickr {
    static let APIBaseURL = "https://api.flickr.com/services/rest/"
  }
  
  // MARK: Flickr Parameter Keys
  struct FlickrParameterKeys {
    static let Method = "method"
    static let APIKey = "api_key"
    static let GalleryID = "gallery_id"
    static let Extras = "extras"
    static let Format = "format"
    static let NoJSONCallback = "nojsoncallback"
    static let PerPage = "per_page"
    static let Page = "page"
  }
  
  // MARK: Flickr Parameter Values
  struct FlickrParameterValues {
    static let ResponseFormat = "json"
    static let DisableJSONCallback = "1" /* 1 means "yes" */
    static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
    static let RecentPhotosMethod = "flickr.photos.getRecent"
    static let GalleryID = "66911286-72157647613641977"
    static let MediumURL = "url_m"
    static let NumberOfItems = "20"
    static let InitialPage = "1"
  }
  
  // MARK: Flickr Response Keys
  struct FlickrResponseKeys {
    static let Status = "stat"
    static let Photos = "photos"
    static let Photo = "photo"
    static let Title = "title"
    static let MediumURL = "url_m"
    static let ID = "id"
  }
  
  // MARK: Flickr Response Values
  struct FlickrResponseValues {
    static let OKStatus = "ok"
  }
  
  struct SerializationErrorDesc {
    static let TitleMissing = " "
    static let URLMissing   = " "
    static let IDMissing    =  " "
  }
}
