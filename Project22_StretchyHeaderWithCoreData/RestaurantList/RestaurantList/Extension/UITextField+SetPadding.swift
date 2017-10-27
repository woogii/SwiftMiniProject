//
//  UITextField+SetPadding.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 20..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - UITextField Extension
extension UITextField {
  // MARK : - Set Left Padding
  func setLeftPaddingPoints( _ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
}
