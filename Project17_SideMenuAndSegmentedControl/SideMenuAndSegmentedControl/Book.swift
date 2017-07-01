//
//  Book.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 1..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Book (Struct)

struct Book {

  // MARK : - Property
  
  var title:String
  var author:String
  var isbn:String
  var bookCoverImageUrl:String?
  var lastPageRead:Int
  var totalPage:Int
  var isDownloaded:Bool
  
  // MARK : - Initialization 
  
  init(dictionary:[String:Any]) {
    
    title  = dictionary["title"] as? String ?? ""
    author = dictionary["author"] as? String ?? ""
    isbn   = dictionary["isbn"] as? String ?? ""
    lastPageRead = dictionary["lastPageRead"] as? Int ?? 0
    totalPage    = dictionary["totalPage"] as? Int ?? 0
    isDownloaded = dictionary["isDownloaded"] as? Bool ?? false
    bookCoverImageUrl = nil
    
  }
  
  
  
  
  
}
