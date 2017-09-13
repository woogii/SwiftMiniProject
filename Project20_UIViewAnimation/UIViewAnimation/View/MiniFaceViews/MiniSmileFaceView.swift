//
//  MiniSmileFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - MiniSmileView : UIView

class MiniSmileFaceView: FaceView {

  override init(frame: CGRect) {

    super.init(frame: frame)

    configureMiniSmileFaceViewProperties()
  }

  func configureMiniSmileFaceViewProperties() {
    self.lineWidth = 3
    self.mouthCurvature = 1.0
    self.lineWidth = 3
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draw(_ rect: CGRect) {

    super.draw(rect)
    drawSkullAndHeart()
  }

  private func drawSkullAndHeart() {
    color.set()
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}
