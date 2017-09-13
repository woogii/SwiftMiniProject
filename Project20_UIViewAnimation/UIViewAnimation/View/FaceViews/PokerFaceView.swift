//
//  PokerFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - PokerFaceView : UIView

class PokerFaceView: FaceView {

  override func draw(_ rect: CGRect) {

    super.draw(rect)
    drawSkullAndHeart()
  }

  // MARK : - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    configurePokerFaceViewProperties()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configurePokerFaceViewProperties() {
    eyesOpen = false
    mouthCurvature = 0.1
  }

  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}
