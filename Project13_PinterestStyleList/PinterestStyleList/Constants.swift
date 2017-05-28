//
//  MindvalleyConstants.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants

struct Constants {
  
  // MARK : - Public Constants
  
  struct Public {
    static let DefaultListSize = 10
  }
  
  // MARK : - Storyboard Name
  
  struct StoryboardName {
    
    static let Main = "Main"
  }
  
  // MARK : - JSON Response Keys
 
  struct JSONResponseKeys {
    
    // MARK : - General Keys 
    
    static let Id         = "user"
    static let CreatedAt  = "created_at"
    static let LikesCount = "likes"
  
    // MARK : - User Information
    
    struct UserInfo {
      
      static let User   = "user"
      static let Id =  "id"
      static let UserName =  "username"
      static let Name  = "name"
      static let ProfileImage = "profile_image"
      static let ProfileLinks = "links"
      
    }
    
    // MARK : - URL Information
    
    struct UrlInfo {
      
      static let Urls = "urls"
      static let RawImage = "raw"
      static let SmallImage = "small"
      static let RegularImage = "regular"
      static let ThumbnailImage = "thumb"
    
    }
    
    struct UserCollectionInfo {
      static let UserCollections = "current_user_collections"
    }
    
    // MARK : - Category Information
    
    struct CategoryInfo {
      
      static let Categories = "categories"
      static let Id = "id"
      static let Title = "title"
      static let PhotoCount = "photo_count"
      static let Links = "links"
      static let SelfKey = "self"
      static let Photos = "photos"
      
    }
    
    // MARK : - Error Information
    
    struct ErrorInfo {
      static let Code = "ErrCode"
      static let Message = "ErrMessage"
      static let Domain = "MindValleyImage Error"
    }
    
  }
  
  // MARK : - Cell ID
  
  struct ImageListCollectionViewCell {
    static let Identifier = "imageListCollectionViewCell"
    static let BackgroundImageViewCornerRadius:CGFloat = 4
    static let ProfileImageViewCornerRadius:CGFloat = 4
    static let ContentBackgroundViewCornerRadius:CGFloat = 3
    static let ContentBackgroundViewShadowOpacity:Float = 0.8
    static let ImageListCollectionViewCelllHeight:CGFloat = 225
  }
  
  
  // MARK : - ImageListVC
  
  struct ImageListVC {
    static let BundleResourceName = "sampleData"
    static let FileTypeJSON = "json"
    static let USPosixLocale = "en_US_POSIX"
    static let JsonDateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    static let NumberOfColumns:CGFloat = 2
    static let NumberOfRequestedPostList = 10
  }
  
  struct MindValleyCache {
    static let MaximumCapacity = 500
  }
  
  struct Image {
    static let PlaceHolder = "placeholder"
  }
  
}
