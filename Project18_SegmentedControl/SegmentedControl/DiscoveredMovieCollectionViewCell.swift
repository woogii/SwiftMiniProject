//
//  DiscoveredMovieCollectionViewCell.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

// MARK : - DiscoveredMovieCollectionViewCell : UICollectionViewCell  

class DiscoveredMovieCollectionViewCell : UICollectionViewCell  {
  
  // MARK : - Property 
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var likesImageView: UIImageView!
  @IBOutlet weak var numberOfLikesLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  var movieInfo : Movie! {
    didSet {
      updateUI()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    posterImageView.layer.shadowColor = UIColor.black.cgColor
    posterImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
    posterImageView.layer.shadowOpacity = 1
    posterImageView.layer.shadowRadius = 1.0
    posterImageView.clipsToBounds = false
  }
  
  
  // MARK : - Update UI 
  
  func updateUI() {
    
    setTitleLabel()
    setVoteAverage()
    setPosterImageView()
  }
  
  func setTitleLabel() {
    titleLabel.text = movieInfo.originalTitle
  }
  
  func setVoteAverage() {
    numberOfLikesLabel.text = "\(movieInfo.voteAverage)"
  }
  
  func setPosterImageView() {
  
    let imageUrlString = Constants.API.BaseImageUrl + Constants.API.PosterImageSize + movieInfo.posterPath
    
    print(imageUrlString)
    
    guard let imageUrl = URL(string: imageUrlString) else {
      return
    }
    
    
    posterImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: SDWebImageOptions() ) { (image, error, cacheType, url) in
      
      if image != nil {
        DispatchQueue.main.async {
          
          self.posterImageView.image = image//self.resizeImage(sourceImage: image!, scaledToWidth: UIScreen.main.bounds.size.width)
          
          let shadowPath = UIBezierPath(rect: self.posterImageView.bounds).cgPath
          self.posterImageView.layer.shadowColor = UIColor.black.cgColor
          //(white: 0.7, alpha: 0.7).cgColor
          self.posterImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
          self.posterImageView.layer.shadowOpacity = 0.4
          self.posterImageView.layer.masksToBounds = false
          self.posterImageView.layer.shadowPath = shadowPath
          self.posterImageView.layer.cornerRadius = 2
        }
      }
      
    }
  }
  

  func resizeImage (sourceImage:UIImage, scaledToWidth: CGFloat) -> UIImage {
    
    let oldWidth = sourceImage.size.width
    let scaleFactor = scaledToWidth / oldWidth
    
    //let newHeight:CGFloat = imageHieghtConstraint   // sourceImage.size.height * scaleFactor
    let newHeight:CGFloat = sourceImage.size.height * scaleFactor
    let newWidth = oldWidth * scaleFactor
    
    UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
    sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

  
}


extension UIView {
  
  func addShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 1
    layer.shadowRadius = 5
    clipsToBounds = false
  }
}

