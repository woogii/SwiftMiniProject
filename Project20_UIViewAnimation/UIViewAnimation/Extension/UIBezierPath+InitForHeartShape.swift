//
//  UIBezierPath+InitForHeartShape.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - Extension : UIBezierPath

extension UIBezierPath {

  // MARK : - Convenience Init

  convenience init(heartIn rect: CGRect) {

    self.init()

    //Calculate Radius of Arcs using Pythagoras
    let sideOne = rect.width * 0.4
    let sideTwo = rect.height * 0.3
    let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
    let originX: CGFloat = rect.origin.x * 4
    let originY: CGFloat = rect.origin.y * 2

    //Left Hand Curve
    self.addArc(withCenter: CGPoint(x: originX + rect.width * 0.3,
                                    y: originY + rect.height * 0.35),
                                    radius: arcRadius, startAngle: 135.degreesToRadians,
                                    endAngle: 315.degreesToRadians, clockwise: true)

    //Top Centre Dip
    self.addLine(to: CGPoint(x: originX + rect.width/2, y: originY + rect.height * 0.2))

    //Right Hand Curve
    self.addArc(withCenter: CGPoint(x: originX + rect.width * 0.7,
                                    y: originY + rect.height * 0.35),
                radius: arcRadius, startAngle: 225.degreesToRadians,
                endAngle: 45.degreesToRadians, clockwise: true)

    //Right Bottom Line
    self.addLine(to: CGPoint(x: originX + rect.width * 0.5, y: originY + rect.height * 0.95))

    //Left Bottom Line
    self.close()
  }
}
