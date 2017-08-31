//
//  SmileFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SmileFaceView : UIView

class SmileFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    color.set()
    mouthCurvature = 1.0
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}

