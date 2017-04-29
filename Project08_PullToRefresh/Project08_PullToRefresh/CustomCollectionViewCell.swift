//
//  CustomCollectionViewCell.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CustomCollectionViewCell: UICollectionViewCell

class CustomCollectionViewCell: UICollectionViewCell {
  
  // MARK : - Property
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var creatorLabel: UILabel!
  @IBOutlet weak var contentBackgroundView: UIView!
  @IBOutlet weak var likeIconImageView: UIImageView!
  @IBOutlet weak var numberOfLikesLabel: UILabel!
  @IBOutlet weak var timeInfoLabel: UILabel!
  
  var photoInfo : PhotoInfo! {
  
    didSet {
      updateCell()
    }
  }
  
  func updateCell() {
    
  }
  
  // MARK : - Nib File Loading
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyCornerRadiusToBackgroundImageView()
    applyCornerRadiusToProfileImageView()
    configureBackgroundView()
    changeLikeIconImageViewColor()
  }
  
  func changeLikeIconImageViewColor() {
    likeIconImageView.image? = (likeIconImageView.image?.withRenderingMode(.alwaysTemplate))!
    likeIconImageView.tintColor = UIColor.gray
  }
  
  func configureBackgroundView() {
    
    contentBackgroundView.backgroundColor = UIColor.white
    contentBackgroundView.layer.cornerRadius = 4
    contentBackgroundView.layer.masksToBounds = false
    contentBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    contentBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
    contentBackgroundView.layer.shadowOpacity = 0.8
  }
  
  
  func applyCornerRadiusToBackgroundImageView() {
    backgroundImageView.layer.cornerRadius = 4
    backgroundImageView.layer.masksToBounds = true
  }
  
  func applyCornerRadiusToProfileImageView() {
    profileImageView.layer.cornerRadius  = 4
    profileImageView.layer.masksToBounds = true
  }

  
}
