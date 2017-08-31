//
//  MiniHeartFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - MiniHeartFaceView : UIView

class MiniHeartFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawSkullAndHeart()
  }
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    configureMiniHeartFaceViewProperties()
  }
  
  func configureMiniHeartFaceViewProperties() {
    scaleFactorForHeartEye = 8
    scaleFactorHeartSize = 5
    heartEyeOffset = 7.3
    lineWidth = 3
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForHeart(.left).stroke()
    pathForHeart(.right).stroke()
    pathForMouth().stroke()
  }
}

