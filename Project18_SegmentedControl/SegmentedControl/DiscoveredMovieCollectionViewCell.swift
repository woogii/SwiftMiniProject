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

class DiscoveredMovieCollectionViewCell: UICollectionViewCell {

  // MARK : - Property

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var likesImageView: UIImageView!
  @IBOutlet weak var numberOfLikesLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!

  var movieInfo: Movie! {
    didSet {
      updateUI()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    addOverlayView()
  }

  private func addOverlayView() {
    let overlayView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: posterImageView.frame.size.width, height: posterImageView.frame.size.height))
    overlayView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
    posterImageView.addSubview(overlayView)
  }

  // MARK : - Update UI

  private func updateUI() {

    setTitleLabel()
    setVoteAverage()
    setPosterImageView()
  }

  private func setTitleLabel() {
    titleLabel.text = movieInfo.originalTitle
  }

  private func setVoteAverage() {
    numberOfLikesLabel.text = "\(movieInfo.voteAverage)"
  }

  private func setPosterImageView() {

    let imageUrlString = buildImageUrl()

    guard let imageUrl = URL(string: imageUrlString) else {
      return
    }

    if let image = SDImageCache.shared().imageFromMemoryCache(forKey: imageUrl.absoluteString) {
      self.posterImageView.image = image

    } else {

      posterImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: SDWebImageOptions() ) { (image, _, _, _) in

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

  private func buildImageUrl() -> String {
    return Constants.API.BaseImageUrl + Constants.API.PosterImageSize + movieInfo.posterPath
  }

  func resizeImage (sourceImage: UIImage, scaledToWidth: CGFloat) -> UIImage {

    let oldWidth = sourceImage.size.width
    let scaleFactor = scaledToWidth / oldWidth

    let newHeight: CGFloat = sourceImage.size.height * scaleFactor
    let newWidth = oldWidth * scaleFactor

    UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
    sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

}
