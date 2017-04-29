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
  
  // MARK : - Initialization
  
  init(photoInfoDictionary:[String:AnyObject]) {
    
    let title = photoInfoDictionary[Constants.FlickrResponseKeys.Title] as? String ?? ""
    let mediumUrl = photoInfoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String ?? ""
    let id = photoInfoDictionary[Constants.FlickrResponseKeys.ID] as? String ?? ""
    let numberOfLikes = Int(arc4random_uniform(UInt32(photoInfoDictionary.count)))
    let timeInterval = Int(arc4random_uniform(UInt32(3600*24))) * -1
    let date = Date(timeIntervalSinceNow: (Double)(timeInterval))
    
    self.title = title
    self.mediumUrl = mediumUrl
    self.id = id
    self.numberOfLikes = numberOfLikes
    self.registeredDate = date
  }
  
  // MARK : - Create PhotoInfo List
  
  static func createPhotoInfoList(photoInfoDictionaryArray:[[String:AnyObject]])->[PhotoInfo] {
    
    var photoInfoArray = [PhotoInfo]()
    
    for photoInfoDict in photoInfoDictionaryArray {
      
      let photoInfo = PhotoInfo(photoInfoDictionary: photoInfoDict)
      photoInfoArray.append(photoInfo)
    }
    
    return photoInfoArray
  }
  
}
