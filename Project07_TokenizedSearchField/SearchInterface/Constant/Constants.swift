//
//  Constants.swift
//  SearchInterface
//
//  Created by siwook on 2017. 10. 1..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants
struct Constants {
  // MARK : - StoryboardIDs
  struct StoryboardIDs {
    static let KeywordInputVCStoryboardID = "keywordInputVC"
  }
  // MARK : - NibFiles
  struct NibFiles {
    static let SearchKeywordContainer = "SearchKeywordContainerView"
    static let SearchKeywordCell = "SearchKeywordCollectionViewCell"
  }
  // MARK : - CellIDs
  struct CellIDs {
    static let SearchKeyword = "searchKeywordCollectionViewCell"
  }
  // MARK : - Colors
  struct Colors {
    static let NavigationBar = UIColor(red: 101.0/255.0, green: 158.0/255.0,
                                    blue: 199.0/255.0, alpha: 0.4)
  }
  // MARK : - Icons
  struct Icons {
    static let SearchIcon = "ic_search"
    static let ClearIcon = "ic_clear"
  }
  static let viewFileName = "SearchKeywordContainerView"
  static let CornerRadiusValue: CGFloat = 4
  static let MainStoryboard = "Main"
}
