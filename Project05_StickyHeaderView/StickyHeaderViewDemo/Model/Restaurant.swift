//
//  Restaurant.swift
//  StickyHeaderViewDemo
//
//  Created by siwook on 2017. 4. 1..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation

// MARK : - RestaurantInfo 

struct RestaurantInfo {
  
  // MARK : - Property
  var iconImageName:String
  var description:String
  
  // MARK : - Initialization

  init(iconImageName:String, description:String) {
    self.iconImageName = iconImageName
    self.description = description
  }
  
  // MARK : - Create Dummy Data 

  static func createRestaurantInfo()->[RestaurantInfo]{
    return [RestaurantInfo(iconImageName: Constants.IconImageName.Phone, description: Constants.RestaurantPhoneNumber),RestaurantInfo(iconImageName:Constants.IconImageName.Mail, description: Constants.RestaurantMailAddress),RestaurantInfo(iconImageName:Constants.IconImageName.Link, description: Constants.RestaurantHomePage)]
  }
}
