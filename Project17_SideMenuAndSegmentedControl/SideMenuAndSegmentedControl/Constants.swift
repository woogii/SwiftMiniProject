//
//  Constants.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 1..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation


// MARK : - Constants 

struct Constants {
  
  static let BookListJSONFileName = "bookList"
  static let BookListJSONFileType = "json"
  static let MenuTitle = ["Search","Sync","All Items","Books","Newsstand",
                   "Docs","Collections","Audio Companions",
                   "Help","Settings"]
  static let SyncDateInfoDefaultText = "Last synced on "

  // MARK : - Storyboard Name
  
  struct StorybordName {
    static let Main = "Main"
  }
  
  // MARK : - Storyboard ID
  
  struct StoryboardID {
    static let NavigationController = "NavigationController"
    static let BookListVC = "BookListVC"
  }

  // MARK : - Google Book API
  
  struct GoogleBookAPI {
    
    static let BaseUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:"
    
    struct JSONResponseKeys {
      
      static let Items = "items"
      static let ImageLinks = "imageLinks"
      static let VolumeInfo = "volumeInfo"
      static let SmallThumbnail = "smallThumbnail"
      static let Thumbnail = "thumbnail"
      
    }
  }
  
  // MARK : - JSONKeys 
  
  struct JSONKeys {
  
    // MARK : - BookInfo
    
    struct BookInfo {
      
      static let Title = "title"
      static let Author = "author"
      static let Isbn = "isbn"
      static let LastPageRead = "lastPageRead"
      static let TotalPage = "totalPage"
      static let IsDownloaded = "isDownloaded"
      
    }
    
  }
  
  
  
  // MARK : - CellID 
  
  struct CellID {
    static let BookItemTableViewCell = "bookItemTableViewCell"
    static let SideMenuTableViewCell = "sideMenuTableViewCell"
  }
  
}

// MARK : - MenuType (enum)

enum MenuType : Int {
  
  case Search = 0
  case Sync
  case AllItems
  case Books
  case Newsstand
  case Docs
  case Collections
  case AudioCompanions
  case Help
  case Settings
}

