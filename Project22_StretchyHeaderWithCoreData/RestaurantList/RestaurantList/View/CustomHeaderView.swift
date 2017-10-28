//
//  CustomHeaderView.swift
//  RestaurantList
//
//  Created by siwook on 2017. 10. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {

  @IBOutlet weak var backgroundImageView: UIImageView!

  var backgroundImage: UIImage? {
    didSet {
      if let image = backgroundImage {
        backgroundImageView.image = image
      } else {
        backgroundImageView.image = nil
      }
    }
  }
}
