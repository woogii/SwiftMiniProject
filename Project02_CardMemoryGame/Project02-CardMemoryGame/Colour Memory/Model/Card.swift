//
//  Card.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 4. 23..
//  Copyright © 2016년 siwook. All rights reserved.
//

import Foundation

// MARK : - Card : NSObject

class Card: NSObject {

  // MARK : Property

  var isSelected: Bool = false
  var isMatched: Bool = false
  var colourDesc: String = ""

  // MARK : Matching Cards

  func match(_ otherCards: [Card]) -> Int {

    var score = 0

    for otherCard in otherCards {
      if otherCard.colourDesc == colourDesc {
        // if both cards have same descriptions, we add the matching points
        score += Constants.MatchingPoint
      }
    }

    return score
  }

}
