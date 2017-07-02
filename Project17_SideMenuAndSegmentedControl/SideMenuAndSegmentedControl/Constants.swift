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
  
  // MARK : Google Book API 
  
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
  }
  
}
