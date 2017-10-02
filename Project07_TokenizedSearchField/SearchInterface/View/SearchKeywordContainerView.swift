//
//  SearchContainerView.swift
//  SearchInterface
//
//  Created by siwook on 2017. 4. 7..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SearchKeywordContainerView: UIView

class SearchKeywordContainerView: UIView {

  // MARK : - Property
  @IBOutlet weak var clearButton: UIButton!
  @IBOutlet weak var placeHolderLabel: UILabel!
  @IBOutlet weak var keywordCollectionView: UICollectionView!
  @IBOutlet weak var searchIconImageView: UIImageView!
  static let viewFileName = "SearchKeywordContainerView"
  let searchIconName = "ic_search"
  let clearIconName = "ic_clear"
  // MARK : - Nib File Loading
  override func awakeFromNib() {
    super.awakeFromNib()
    setCornerRadius()
    setSubviewsHiddenStatus()
    setSearchIconImageViewColor()
    setClearIconImageViewColor()
  }
  func setSearchIconImageViewColor() {
    let origImage = UIImage(named: searchIconName)
    searchIconImageView.image = origImage?.withRenderingMode(.alwaysTemplate)
    searchIconImageView.tintColor = UIColor.white
  }
  func setClearIconImageViewColor() {
    let buttonImage = UIImage(named: clearIconName)
    let tintedImage = buttonImage?.withRenderingMode(.alwaysTemplate)
    clearButton.setImage(tintedImage, for: .normal)
    clearButton.tintColor = UIColor.white
  }
  func setCornerRadius() {
    layer.cornerRadius = 5
    layer.masksToBounds = true
  }
  func setSubviewsHiddenStatus() {
    keywordCollectionView.isHidden = true
    placeHolderLabel.isHidden = false
  }
  class func instanceFromNib() -> SearchKeywordContainerView {
    guard let searchKeywordContainerView = UINib(nibName: viewFileName,
                                                 bundle: nil)
                .instantiate(withOwner: nil, options: nil)[0] as? SearchKeywordContainerView else {
      fatalError("Caanot create SearchKeywordContainerView")
    }
    return searchKeywordContainerView
  }
}
