//
//  UIImage+DottedLine.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 9. 4..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - UIImage Extension

extension UIImage {
  
  // MARK : - Create Dotted Image 
  
  static func drawDottedImage(width: CGFloat, height: CGFloat, color: UIColor) -> UIImage {
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 1.0, y: 1.0))
    path.addLine(to: CGPoint(x: width, y: 1))
    path.lineWidth = 1.5
    let dashes: [CGFloat] = [path.lineWidth, path.lineWidth * 5]
    path.setLineDash(dashes, count: Int(1.5), phase: 0)
    path.lineCapStyle = .butt
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 2)
    color.setStroke()
    path.stroke()
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return image
  }
}

