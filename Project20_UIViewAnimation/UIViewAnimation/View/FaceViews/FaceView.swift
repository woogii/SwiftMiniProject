//
//  FaceView.swift
//  UIViewAnimation
//
//  Source from Standford CS 193p
//  https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120

import UIKit

// MARK : - FaceView: UIView

class FaceView: UIView {

  // MARK : - Properties 

  var scale: CGFloat = 0.9
  var eyesOpen: Bool = true
  var lineWidth: CGFloat = 10.0
  var color: UIColor = UIColor.white
  var scaleFactorHeartSize: CGFloat = 1
  let heartSize: CGFloat = 40
  var scaleFactorForHeartEye: CGFloat = 1
  var heartEyeOffset: CGFloat = 0
  var mouthCurvature: Double = 1.0 // 1.0 : full smile, -1.0 : full frown, 0.2 : poker face

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private var skullRadius: CGFloat {
    return min(bounds.size.width, bounds.size.height)/2 * scale
  }

  private var skullCenter: CGPoint {
    return CGPoint(x:bounds.midX, y:bounds.midY)
  }

  func pathForSkull() -> UIBezierPath {
    let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0,
                            endAngle: CGFloat.pi*2, clockwise: false)

    path.lineWidth = lineWidth

    return path
  }

  enum Eye {
    case left
    case right
  }

  fileprivate enum Mouth {
    case smile
    case frown
    case pokerFace
  }

  fileprivate func centerOfEye(_ eye: Eye) -> CGPoint {
    let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffSet
    var eyeCenter = skullCenter
    eyeCenter.y -= eyeOffset
    eyeCenter.x += ((eye == .left) ? -1:1) * eyeOffset
    return eyeCenter
  }

  func pathForEye(_ eye: Eye) -> UIBezierPath {

    let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
    let eyeCenter = centerOfEye(eye)

    let path: UIBezierPath

    if eyesOpen {
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0,
                          endAngle: CGFloat.pi*2, clockwise: true)

    } else {
      path = UIBezierPath()
      path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
      path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
    }
    path.lineWidth = lineWidth
    path.fill()

    return path
  }

  func pathForHeart(_ eye: Eye) -> UIBezierPath {

    func startPointOfEye(_ eye: Eye) -> CGPoint {

      var startPoint = CGPoint(x:10 - heartEyeOffset, y: 20 - (heartEyeOffset*2))
      startPoint.x += ((eye == .left) ? 0: 10 - heartEyeOffset)

      return startPoint
    }

    let startPoint = startPointOfEye(eye)
    let path: UIBezierPath
    let heartWidth  = heartSize / scaleFactorHeartSize
    let heartHeight = heartSize / scaleFactorHeartSize

    path = UIBezierPath(heartIn: CGRect(x: startPoint.x, y: startPoint.y, width: heartWidth, height: heartHeight))

    path.fill()

    return path
  }

  func pathForMouth() -> UIBezierPath {

    let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth

    let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
    let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffSet

    let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset,
                          width: mouthWidth, height: mouthHeight)

    let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height

    // .frown
    let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
    let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)

    let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset)
    let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset)

    let path = UIBezierPath()
    path.move(to: start)
    path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
    path.lineWidth = lineWidth

    return path
  }

  func pathForFrown(_ eye: Eye) -> UIBezierPath {

    let eyeRadius = skullRadius / Ratios.skullRadiusToFrownEyeRadius
    let eyeCenter = centerOfEye(eye)
    let path: UIBezierPath

    if eye == .left {
      let angle = CGFloat.pi/8
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: angle,
                          endAngle: CGFloat.pi, clockwise: true)

    } else {

      let angle = -CGFloat.pi/32
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle:  angle,
                          endAngle: CGFloat.pi - CGFloat.pi/8, clockwise: true)

    }
    path.fill()

    return path

  }

  struct Ratios {
    static let skullRadiusToEyeOffSet: CGFloat = 3
    static let skullRadiusToEyeRadius: CGFloat = 6
    static let skullRadiusToFrownEyeRadius: CGFloat = 3
    static let skullRadiusToMouthWidth: CGFloat = 1
    static let skullRadiusToMouthHeight: CGFloat = 3
    static let skullRadiusToMouthOffSet: CGFloat = 3
  }

  func drawFrown() {
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
  }

  override func draw(_ rect: CGRect) {
    // Drawing code
    super.draw(rect)
    color.set()
    pathForSkull().stroke()

  }
}
