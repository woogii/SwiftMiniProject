//
//  Restaurant.swift
//  ImageGallery
//
//  Created by siwook on 2017. 4. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
struct RestaurantInfo {
  var iconImageName: String
  var info: String
  init(iconImageName: String, info: String) {
    self.iconImageName = iconImageName
    self.info = info
  }
  static func createRestaurantInfo() -> [RestaurantInfo] {
    return [RestaurantInfo(iconImageName: "ic_phone", info: "+82-01-1111-2222"),
            RestaurantInfo(iconImageName:"ic_mail", info: "sample@sample.com"),
            RestaurantInfo(iconImageName:"ic_link", info: "http://wwww.github.com/woogii")]
  }
}
