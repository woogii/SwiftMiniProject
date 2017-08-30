//
//  PhotoInfo.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - PhotoInfo

struct PhotoInfo {

  // MARK : - Property
  
  var title:String
  var mediumUrl:String
  var id:String
  var numberOfLikes:Int
  var registeredDate: Date
  typealias PhotoRequestResult = (_ result:[PhotoInfo]?,_ error:Error?)->(Void)
  enum SerializationError: Error {
    case missing(String)
  }
  
  // MARK : - Initialization
  
  init(photoInfoDictionary:[String:Any]) throws {
    
    guard let title = photoInfoDictionary[Constants.FlickrResponseKeys.Title] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.TitleMissing)
    }
    
    guard let mediumUrl = photoInfoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.URLMissing)
    }
    
    guard let id = photoInfoDictionary[Constants.FlickrResponseKeys.ID] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.IdMissing)
    }
    
    let numberOfLikes = Int(arc4random_uniform(UInt32(photoInfoDictionary.count)))
    let timeInterval = Int(arc4random_uniform(UInt32(3600*24))) * -1
    let date = Date(timeIntervalSinceNow: (Double)(timeInterval))
    
    self.title = title
    self.mediumUrl = mediumUrl
    self.id = id
    self.numberOfLikes = numberOfLikes
    self.registeredDate = date
  }
  
}

// MARK : - Extension

extension PhotoInfo {

  // MARK : - Network Request 
  
  static func requestPhotoInfoList(currentPage: Int, completionHandler:@escaping PhotoRequestResult) {
    
    guard let photoListUrl = buildRequestUrl(currentPage: currentPage) else {
      return
    }
    
    URLSession.shared.dataTask(with:photoListUrl, completionHandler: { (data, _, error) in
      
      var photoInfoList:[PhotoInfo] = []

      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
        let jsonDict = json?[Constants.FlickrResponseKeys.Photos] as? [String:Any],
        let photoInfoArray = jsonDict[Constants.FlickrResponseKeys.Photo] as? [[String:Any]] {
        
        for case let photoItem in photoInfoArray {
          if let photoInfo = try? PhotoInfo(photoInfoDictionary: photoItem) {
            photoInfoList.append(photoInfo)
          }
        }
      
        completionHandler(photoInfoList, error)
      }
      
    }).resume()
    
  }
  
  static func buildRequestUrl(currentPage:Int)->URL?{
    
    guard var urlComponent = URLComponents(string: Constants.Flickr.APIBaseURL) else {
      return nil
    }
    
    urlComponent.queryItems = [
      URLQueryItem(name: Constants.FlickrParameterKeys.Method, value: Constants.FlickrParameterValues.RecentPhotosMethod)
      ,URLQueryItem(name: Constants.FlickrParameterKeys.APIKey, value: Secret.APIKey)
      ,URLQueryItem(name: Constants.FlickrParameterKeys.Extras, value: Constants.FlickrParameterValues.MediumURL)
      ,URLQueryItem(name: Constants.FlickrParameterKeys.Format, value: Constants.FlickrParameterValues.ResponseFormat)
    ,URLQueryItem(name: Constants.FlickrParameterKeys.PerPage, value: Constants.FlickrParameterValues.NumberOfItems)
    ,URLQueryItem(name: Constants.FlickrParameterKeys.Page, value: String(currentPage))
     ,URLQueryItem(name: Constants.FlickrParameterKeys.NoJSONCallback, value: Constants.FlickrParameterValues.DisableJSONCallback)
    ]
    
    return urlComponent.url
  }
  
}
