//
//  HeartFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - HeartFaceView : UIView

class HeartFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForHeart(.left).stroke()
    pathForHeart(.right).stroke()
    pathForMouth().stroke()
  }
}

