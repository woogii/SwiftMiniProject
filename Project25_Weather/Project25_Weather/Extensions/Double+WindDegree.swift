//
//  Double+WindDegree.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - Double Extension For Wind Direction
extension Double {

  func windDegreeToString() -> String {
    if self >= 0.0 && self < 90.0 {
      return Constants.NorthEast
    } else if self >= 90.0 && self < 180.0 {
      return Constants.NorthWest
    } else if self >= 180.0 && self < 270.0 {
      return Constants.SouthWest
    } else {
      return Constants.SouthEast
    }
  }
}
