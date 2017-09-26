//
//  GenreCollectionViewCell.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 8. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage

// MARK : - GenreCollectionViewCell : UICollectionViewCell

class GenreCollectionViewCell: UICollectionViewCell {

  // MARK : - Property

  @IBOutlet weak var genreTitleLabel: UILabel!
  @IBOutlet weak var representativeImageView: UIImageView!

  var genreInfo: Genre! {
    didSet {
      updateUI()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    addOverlayView()
  }

  private func addOverlayView() {
    let overlayView: UIView = UIView(frame: CGRect(x: 0, y: 0,
                                                   width: representativeImageView.frame.size.width,
                                                   height: representativeImageView.frame.size.height))
    overlayView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
    representativeImageView.addSubview(overlayView)
  }

  // MARK : - Update UI

  private func updateUI() {

    setTitleLabel()
    setPosterImageView()
  }

  private func setTitleLabel() {
    genreTitleLabel.text = genreInfo.name
  }

  private func setPosterImageView() {

    let imageUrlString = buildImageUrl()

    guard let imageUrl = URL(string: imageUrlString) else {
      return
    }

    if let image = SDImageCache.shared().imageFromMemoryCache(forKey: imageUrl.absoluteString) {
      self.representativeImageView.image = image

    } else {

      representativeImageView.sd_setImage(with: imageUrl,
                                          placeholderImage: UIImage(),
                                          options: SDWebImageOptions() ) { (image, _, _, _) in

        if image != nil {

          UIView.transition(with: self.representativeImageView,
                            duration: 0.5,
                            options: .transitionCrossDissolve, animations: {
            DispatchQueue.main.async {
              self.representativeImageView.image = image
            }
          }, completion: nil)

        }
      }
    }
  }

  private func buildImageUrl() -> String {
    return Constants.API.BaseImageUrl + Constants.API.PosterImageSize + genreInfo.posterPath
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
