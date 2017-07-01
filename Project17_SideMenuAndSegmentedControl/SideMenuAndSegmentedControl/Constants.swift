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
  
  
  static let bookListJSON = "bookList.json"
  struct JSONKeys {
    
    struct BookInfo {
      
      static let Title = "title"
      static let Author = "author"
      static let Isbn = "isbn"
      static let LastPageRead = "lastPageRead"
      static let TotalPage = "totalPage"
      static let IsDownloaded = "isDownloaded"
      
    }
    
  }
  
  struct CellID {
    static let BookItemTableViewCell = "bookItemTableViewCell"
  }
  
}
