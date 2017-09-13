//
//  DescriptionCollectionViewCell.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 7. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - DescriptionCollectionViewCell: UICollectionViewCell

class DescriptionCollectionViewCell: UICollectionViewCell {

  // MARK : - Property

  @IBOutlet weak var titleLabel: UILabel!

  @IBOutlet weak var secondSeparatorView: UIView!
  @IBOutlet weak var thirdSeparatorView: UIView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dismissButton: UIButton!
  @IBOutlet weak var dismissAndRemoveButton: UIButton!
  @IBOutlet weak var upperSeparatorImageView: UIImageView!
  @IBOutlet weak var middleSeparatorImageView: UIImageView!
  @IBOutlet weak var lowerSeparatorImageView: UIImageView!
  let dottedImageHeight: CGFloat = 1

  var descriptionItem: DescriptionItem! {
    didSet {
      updateUI()
    }
  }

  // MARK : - Nib File Loading 

  override func awakeFromNib() {
    super.awakeFromNib()

    upperSeparatorImageView.image = UIImage.drawDottedImage(width: frame.width,
                                                            height: dottedImageHeight, color: UIColor.black)
    middleSeparatorImageView.image = UIImage.drawDottedImage(width: frame.width,
                                                             height: dottedImageHeight, color: UIColor.black)
    lowerSeparatorImageView.image = UIImage.drawDottedImage(width: frame.width,
                                                            height: dottedImageHeight, color: UIColor.black)
  }

  // MARK : - Update UI

  func updateUI() {
    titleLabel.text = descriptionItem.title
    descriptionLabel.text = descriptionItem.description

    middleSeparatorImageView.isHidden = true
    lowerSeparatorImageView.isHidden = true
    dismissButton.isHidden = true
    dismissAndRemoveButton.isHidden = true
  }

}
