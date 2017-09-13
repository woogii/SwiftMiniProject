//
//  FrownFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - FrownFaceView: UIView

class FrownFaceView: FaceView {

  override func draw(_ rect: CGRect) {

    super.draw(rect)
    drawSkullAndHeart()
  }

  // MARK : - Initialization 

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureFrownFaceViewProperties()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureFrownFaceViewProperties() {
    mouthCurvature = 0.1
  }

  private func drawSkullAndHeart() {
    color.set()
    pathForSkull().stroke()
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    pathForMouth().stroke()
  }
}
