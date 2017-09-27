//
//  Constants.swift
//  Project01-BarGraphInCollectionView
//
//  Created by siwook on 2017. 9. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants
struct Constants {
  static let CellIdentifier = "barGraphCollectionViewCell"
  static let FigureSuffix = "%"
  static let NumberOfData = 5
  static let CellBackgroundHeight: Float = 221.0
  // MARK : - Colors
  struct Colors {
    static let DarkRed = UIColor(red: 103.0/255.0, green: 178.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    static let LightRed = UIColor(red: 76.0/255.0, green: 162.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    static let DrakGreen = UIColor(red: 255.0/255.0, green: 106.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let LightGreen = UIColor(red: 238.0/255.0, green: 9.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    static let Blue = UIColor(red: 255.0/255.0, green: 252.0/255.0, blue: 0.0/255.0, alpha: 1.0)
  }
}
