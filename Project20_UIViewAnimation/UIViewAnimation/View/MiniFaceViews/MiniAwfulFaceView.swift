//
//  MiniAwfulFaceView.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - MiniAwfulFaceView : UIView

class MiniAwfulFaceView: FaceView {

  override func draw(_ rect: CGRect) {

    super.draw(rect)
    drawSkullAndHeart()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureMiniAwfulFaceViewProperties()
  }

  func configureMiniAwfulFaceViewProperties() {
    mouthCurvature = -1
    lineWidth = 3
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    pathForMouth().stroke()
  }
}
