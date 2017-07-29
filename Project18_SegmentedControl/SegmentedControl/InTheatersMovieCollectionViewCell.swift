//
//  InTheatersMovieCollectionViewCell.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage

class InTheatersMovieCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var posterImageView: UIImageView!
  
  var movieInfo : Movie! {
    didSet {
      updateUI()
    }
  }

  private func updateUI() {
    setPosterImageView()
  }
  
  private func setPosterImageView() {
    
    let imageUrlString = buildImageUrl()
    
    guard let imageUrl = URL(string: imageUrlString) else {
      return
    }
    
    if let image = SDImageCache.shared().imageFromMemoryCache(forKey: imageUrl.absoluteString) {
      self.posterImageView.image = image
      
    } else {
      
      posterImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: SDWebImageOptions() ) { (image, error, cacheType, url) in
        
        if image != nil {
          
          UIView.transition(with: self.posterImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            DispatchQueue.main.async {
              self.posterImageView.image = image
            }
          }, completion: nil)
          
        }
      }
    }
  }

  private func buildImageUrl()->String {
    return Constants.API.BaseImageUrl + Constants.API.PosterImageSize + movieInfo.posterPath
  }
  
  
}
