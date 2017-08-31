//
//  AwfulFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - AwfulFaceView : UIView

class AwfulFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    drawSkullAndHeart()
  }
  
  // MARK : - Initialization
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    configureAwfulFaceViewProperties()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureAwfulFaceViewProperties() {
    mouthCurvature = -1
  }
  
  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    pathForMouth().stroke()
  }
}
