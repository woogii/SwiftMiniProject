//
//  Book.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 1..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Book

struct Book {

  // MARK : - Property

  var title: String
  var author: String
  var isbn: String
  var bookCoverImageUrl: String?
  var lastPageRead: Int
  var totalPage: Int
  var isDownloaded: Bool

  // MARK : - Initialization 

  init?(dictionary: [String:Any]) {
    print(dictionary)
    title  = dictionary[Constants.JSONKeys.BookInfo.Title] as? String ?? ""
    author = dictionary[Constants.JSONKeys.BookInfo.Author] as? String ?? ""
    isbn   = dictionary[Constants.JSONKeys.BookInfo.Isbn] as? String ?? ""
    lastPageRead = dictionary[Constants.JSONKeys.BookInfo.LastPageRead] as? Int ?? 0
    totalPage    = dictionary[Constants.JSONKeys.BookInfo.TotalPage] as? Int ?? 0
    isDownloaded = (dictionary[Constants.JSONKeys.BookInfo.IsDownloaded] as? String ?? "").toBool()
    bookCoverImageUrl = nil

  }

}

extension String {

  func toBool() -> Bool {
    switch self {
    case "True", "true", "yes", "1":
      return true
    case "False", "false", "no", "0":
      return false
    default:
      return false
    }
  }
}
