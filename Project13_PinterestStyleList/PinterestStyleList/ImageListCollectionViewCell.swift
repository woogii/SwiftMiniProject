//
//  ImageListCollectionViewCell.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ImageListCollectionViewCell: UICollectionViewCell

class ImageListCollectionViewCell: UICollectionViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var creatorLabel: UILabel!
  @IBOutlet weak var contentBackgroundView: UIView!
  @IBOutlet weak var likeIconImageView: UIImageView!
  @IBOutlet weak var numberOfLikesLabel: UILabel!
  @IBOutlet weak var timeInfoLabel: UILabel!
  @IBOutlet weak var backgroundImageViewHeightConstraint: NSLayoutConstraint!

  var taskToCancelifCellIsReused: URLSessionTask? {
    
    didSet {
      if let taskToCancel = oldValue {
        taskToCancel.cancel()
      }
    }
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
    contentBackgroundView.layer.cornerRadius = Constants.ImageListCollectionViewCell.ContentBackgroundViewCornerRadius
    contentBackgroundView.layer.masksToBounds = false
    contentBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    contentBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
    contentBackgroundView.layer.shadowOpacity = Constants.ImageListCollectionViewCell.ContentBackgroundViewShadowOpacity
  }

  
  func applyCornerRadiusToBackgroundImageView() {
    backgroundImageView.layer.cornerRadius = Constants.ImageListCollectionViewCell.BackgroundImageViewCornerRadius
    backgroundImageView.layer.masksToBounds = true
  }
  
  func applyCornerRadiusToProfileImageView() {
    profileImageView.layer.cornerRadius = Constants.ImageListCollectionViewCell.ProfileImageViewCornerRadius
    profileImageView.layer.masksToBounds = true
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    if let attributes = layoutAttributes as? CustomCollectionViewLayoutAttributes {
        backgroundImageViewHeightConstraint.constant  = attributes.photoHeight
    }
  }
}
