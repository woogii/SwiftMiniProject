//
//  MiniFrownFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit


// MARK : - MiniFrownFaceView : UIView

class MiniFrownFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    
    drawSkullAndHeart()
  }
  
  override init(frame:CGRect) {
    
    super.init(frame: frame)
    
    configureMiniFrownFaceViewProperties()
  }
  
  func configureMiniFrownFaceViewProperties() {
    lineWidth = 3
    scaleFactorForHeartEye = 8
    scaleFactorHeartSize = 5
    mouthCurvature = 0.1
    heartEyeOffset = 7.3
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func drawSkullAndHeart() {
    color.set()
    pathForSkull().stroke()
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    pathForMouth().stroke()
  }
}
