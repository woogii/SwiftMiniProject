//
//  MenuInfo.swift
//  SlideInMenu
//
//  Created by siwook on 2017. 5. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - MenuInfo 

struct MenuInfo {

  // MARK : - Property
  
  var iconImageName:String
  var title:String
  
  // MARK : - Initialization  
  
  init(iconImageName:String, title:String) {
    self.iconImageName = iconImageName
    self.title = title
  }
}
