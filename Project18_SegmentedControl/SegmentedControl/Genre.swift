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
  
  var id:String
  var name:String
  
  // MARK : - Initialization
  
  init(dictionary:[String:Any]) {
    
    id = dictionary["id"] as? String ?? ""
    name = dictionary["name"] as? String ?? ""
    
  }
  
}
