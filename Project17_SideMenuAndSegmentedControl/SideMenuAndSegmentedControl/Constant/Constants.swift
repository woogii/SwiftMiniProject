//
//  Constants.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 1..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants 

struct Constants {

  static let BookListJSONFileName = "bookList"
  static let BookListJSONFileType = "json"
  static let MenuTitle = ["Search", "Sync", "All Items", "Books", "Newsstand",
                   "Docs", "Collections", "Audio Companions",
                   "Help", "Settings"]

  // MARK : - Storyboard Name

  struct StorybordName {
    static let Main = "Main"
  }

  // MARK : - Storyboard ID

  struct StoryboardID {
    static let NavigationController = "NavigationController"
    static let BookListVC = "BookListVC"
    static let SearchBookVC = "SearchBookVC"

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

  // MARK : - SideMenuVC

  struct SideMenuVC {

    static let RotationAnimationKey = "sidemenuVC.rotationanimationkey"
    static let FirstDepthMenuLeadingConstraintValue: CGFloat  = 15
    static let SecondDepthMenuLeadingConstraintValue: CGFloat = 25
    static let RotateAnimationDelay: Double = 3
    static let SyncDateInfoDefaultText = "Last synced on "
    static let DefaultSyncDate = "2017.7.3 11:05 pm"
  }

  // MARK : - CellID 

  struct CellID {
    static let BookItemTableViewCell = "bookItemTableViewCell"
    static let SideMenuTableViewCell = "sideMenuTableViewCell"
  }

}
