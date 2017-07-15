//
//  Constant.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Constants 

struct Constants {

  // MARK : - API 
  
  struct API {
    
    static let BaseUrl = "https://api.themoviedb.org"
    static let Path = "/3"
  
    struct ParameterKeys {
      static let Method = "method"
      static let ApiKey = "api_key"
      static let ListId = "list_id"
    }
    
    struct Methods {
      static let Configuration = "/configuration"
      static let List = "/list"
    }
    
    
  }
  
  
  // MARK : - Cell ID
  
  struct CellID {
    
    struct CollectionView {
      static let ListAndGenres = "listAndGenresCollectionViewCell"
    }
  }
}
