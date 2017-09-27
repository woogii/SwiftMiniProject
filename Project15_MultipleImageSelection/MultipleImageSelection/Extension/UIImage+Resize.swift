//
//  UIImage+Resize.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 9. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - UIImage Extension
extension UIImage {
  func resizeImage() -> UIImage {
    if size.width < UIScreen.main.bounds.width {
      let scaleToWidth = UIScreen.main.bounds.width
      let oldWidth = size.width
      let scaleFactor = scaleToWidth / oldWidth
      let newHeight = size.height * scaleFactor
      let newWidth = oldWidth * scaleFactor
      UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
      draw(at: .zero)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage!
    } else {
      return self
    }
  }
}
