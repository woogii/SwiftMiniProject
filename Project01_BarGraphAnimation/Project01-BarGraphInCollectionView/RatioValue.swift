//
//  RatioValues.swift
//  Project01-BarGraphInCollectionView
//
//  Created by siwook on 2017. 9. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
// MARK : - RatioValue
struct RatioValue {
  // MARK : - Property
  var firstValue: Float
  var secondValue: Float
  var thirdValue: Float
  // MARK : - Get Ration Value List
  static func getRatioValueList() -> [RatioValue] {
    return [RatioValue(firstValue: 0.6, secondValue: 0.7, thirdValue: 0.8),
            RatioValue(firstValue: 0.3, secondValue: 0.5, thirdValue: 0.9),
            RatioValue(firstValue: 0.6, secondValue: 0.8, thirdValue: 0.4),
            RatioValue(firstValue: 0.7, secondValue: 0.2, thirdValue: 0.6),
            RatioValue(firstValue: 0.6, secondValue: 0.3, thirdValue: 0.2)
           ]
  }
}
