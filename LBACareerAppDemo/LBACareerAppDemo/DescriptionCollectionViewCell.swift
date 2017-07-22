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
  @IBOutlet weak var firstSeparatorView: UIView!
  @IBOutlet weak var secondSeparatorView: UIView!
  @IBOutlet weak var thirdSeparatorView: UIView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dismissButton: UIButton!
  @IBOutlet weak var dismissAndRemoveButton: UIButton!
  
  
  var descriptionItem : DescriptionItem! {
    didSet {
      updateUI()
    }
  }
  
  // MARK : - Update UI
  
  func updateUI() {
    titleLabel.text = descriptionItem.title
    descriptionLabel.text = descriptionItem.description
    
    secondSeparatorView.isHidden = true
    thirdSeparatorView.isHidden = true
    dismissButton.isHidden = true
    dismissAndRemoveButton.isHidden = true
  }
  
  
}
