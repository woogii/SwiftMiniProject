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
  
  init(dictionary:[String:Any]) throws {
    
    guard let id = dictionary[Constants.JSONParsingKeys.Id] as? Int else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.IdMissing)
    }
    
    guard let name = dictionary[Constants.JSONParsingKeys.Name] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.NameMissing)
    }

    self.id = id
    self.name = name
  }
  
  // MARK : - Set Poster URL Path
  
  mutating func setPosterPath(newValue:String) {
    posterPath = newValue 
  }
  
}
