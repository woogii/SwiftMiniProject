//
//  MiniPokerFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - MiniPokerFaceView : UIView

class MiniPokerFaceView: FaceView {

  override func draw(_ rect: CGRect) {

    super.draw(rect)
    drawSkullAndHeart()
  }

  override init(frame: CGRect) {

    super.init(frame: frame)

    configureMiniPokerFaceViewProperties()
  }

  func configureMiniPokerFaceViewProperties() {
    eyesOpen = false
    mouthCurvature = 0.1
    lineWidth = 3
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}
