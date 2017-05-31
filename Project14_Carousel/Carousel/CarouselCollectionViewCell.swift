//
//  CarouselCollectionViewCell.swift
//  Carousel
//
//  Created by siwook on 2017. 5. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CarouselCollectionViewCell: UICollectionViewCell

class CarouselCollectionViewCell: UICollectionViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var lowerVisualEffectView: UIVisualEffectView!
  private let cornerRadiusValue:CGFloat = 5.0
  
  var carouselItem : CarouselItem! {
    didSet {
      updateUI()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setViewCornerRadius()
  }
  
  func setViewCornerRadius() {
    contentView.layer.cornerRadius = cornerRadiusValue
    contentView.layer.masksToBounds = true
    contentView.clipsToBounds = true
  }
  
  // MARK : Update Cell  
  
  func updateUI() {
    
    backgroundImageView.image = UIImage(named: carouselItem.imageName)
    titleLabel.text = carouselItem.title
  }
}
