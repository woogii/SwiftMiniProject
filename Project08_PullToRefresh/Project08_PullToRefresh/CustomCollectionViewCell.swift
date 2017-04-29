//
//  CustomCollectionViewCell.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage


// MARK : - CustomCollectionViewCell: UICollectionViewCell

class CustomCollectionViewCell: UICollectionViewCell {
  
  // MARK : - Property
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var creatorLabel: UILabel!
  @IBOutlet weak var contentBackgroundView: UIView!
  @IBOutlet weak var likeIconImageView: UIImageView!
  @IBOutlet weak var numberOfLikesLabel: UILabel!
  
  @IBOutlet weak var titleInfoLabel: UILabel!
  
  var photoInfo : PhotoInfo! {
  
    didSet {
      updateCell()
    }
  }
  
  func updateCell() {
  
    titleInfoLabel.text = photoInfo.title
    numberOfLikesLabel.text = String(photoInfo.numberOfLikes)
    backgroundImageView.sd_setImage(with:URL(string:photoInfo.mediumUrl), placeholderImage: nil, options: SDWebImageOptions(), completed: { (image, error, cacheType, url) in
      if image != nil {

        UIView.transition(with: self.backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
          DispatchQueue.main.async {
            self.backgroundImageView.image = image
          }
          
        }, completion: nil)
      }
    })
  
    
  }
  
  // MARK : - Nib File Loading
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
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
    contentBackgroundView.clipsToBounds = true 
    contentBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    contentBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
    contentBackgroundView.layer.shadowOpacity = 0.8
  }
  

}
