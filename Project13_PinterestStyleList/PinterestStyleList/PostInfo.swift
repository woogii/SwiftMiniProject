//
//  PostInfo.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - PostInfo

struct PostInfo {
  
  // MARK : - Property 
  
  var userName:String?
  var profileImageUrlString:String?
  var backgroundImageUrlString:String?
  var numberOfLikes:Int?
  var timeInfo:String?
  
  
  // MARK : - Computed Property For Background Image Caching
  
  var backgroundImage: UIImage? {
    get {
      return RestClient.Caches.imageCache.retrieveImage(path: backgroundImageUrlString)
    }
    
    set {
      RestClient.Caches.imageCache.storeImage(image: newValue, path: backgroundImageUrlString!)
    }
  }

  // MARK : - Computed Property For Profile Image Caching
  
  var profileImage: UIImage? {
    get {
      return RestClient.Caches.imageCache.retrieveImage(path: profileImageUrlString)
    }
    
    set {
      RestClient.Caches.imageCache.storeImage(image: newValue, path: profileImageUrlString!)
    }
  }
  
  // MARK : - Initialization 
    
  init?(dictionary:[String:Any]) {
    
    guard let userInfo = dictionary[Constants.JSONResponseKeys.UserInfo.User] as? [String:AnyObject], let profileImageInfo = userInfo[Constants.JSONResponseKeys.UserInfo.ProfileImage] as? [String:AnyObject],let backgroundImageInfo = dictionary[Constants.JSONResponseKeys.UrlInfo.Urls] as? [String:AnyObject] else {
      return nil
    }
    
    self.userName = userInfo[Constants.JSONResponseKeys.UserInfo.UserName] as? String
    self.profileImageUrlString = profileImageInfo[Constants.JSONResponseKeys.UrlInfo.SmallImage] as? String
    self.backgroundImageUrlString = backgroundImageInfo[Constants.JSONResponseKeys.UrlInfo.ThumbnailImage] as? String
    self.numberOfLikes = dictionary[Constants.JSONResponseKeys.LikesCount] as? Int
    self.timeInfo = dictionary[Constants.JSONResponseKeys.CreatedAt] as? String
    
  }
  
  
  
}
