//
//  SearchKeywordCollectionViewCell.swift
//  SearchInterface
//
//  Created by siwook on 2017. 4. 4..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SearchKeywordCollectionViewCell: UICollectionViewCell 

class SearchKeywordCollectionViewCell: UICollectionViewCell {

  // MARK : - Property
  @IBOutlet weak var keywordLabel: UILabel!
  let cellRadius: CGFloat = 4
  let cellBg = UIColor(red: 101.0/255.0, green: 158.0/255.0, blue: 199.0/255.0, alpha: 1.0)
  // MARK : - Nib File Loading
  override func awakeFromNib() {
    super.awakeFromNib()
    setBackgroundColor()
    setKeywordTextColor()
    setCornerRadius()
  }
  func setBackgroundColor() {
    backgroundColor = cellBg
  }
  func setKeywordTextColor() {
    keywordLabel.textColor = UIColor.white
  }
  func setCornerRadius() {
    layer.cornerRadius = cellRadius
  }
}
