//
//  Genre.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 8. 2..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Genre

struct Genre {
  
  // MARK : - Property
  
  var id:Int
  var name:String
  var posterPath:String = ""
  
  
  // MARK : - Initialization
  
  init(dictionary:[String:Any]) {
    
    id = dictionary[Constants.JSONParsingKeys.Id] as? Int ?? 0
    name = dictionary[Constants.JSONParsingKeys.Name] as? String ?? ""
    
  }
  
  // MARK : - Set Poster URL Path
  
  mutating func setPosterPath(newValue:String) {
    posterPath = newValue 
  }
  
}
