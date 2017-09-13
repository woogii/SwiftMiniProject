//
//  Int+Radians.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - Extension : Int

extension Int {
  var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
