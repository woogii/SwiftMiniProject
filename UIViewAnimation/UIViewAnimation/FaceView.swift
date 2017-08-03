//
//  FaceView.swift
//  UIViewAnimation
//
//  Source from Standford CS 193p
//  https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120

import UIKit

class FaceView: UIView {
  
  
  var scale:CGFloat = 0.9
  var eyesOpen : Bool = true
  var lineWidth: CGFloat = 5.0
  var color: UIColor = UIColor.blue
  
  var mouthCurvature : Double = -0.5 // 1.0 is full smile and -1.0 is full frown
  
  private var skullRadius : CGFloat {
    return min(bounds.size.width, bounds.size.height)/2 * scale
  }
  
  private var skullCenter : CGPoint {
    return CGPoint(x:bounds.midX, y:bounds.midY)
  }
  
  private func pathForSkull() -> UIBezierPath {
    let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
    
    path.lineWidth = lineWidth
    // lineWidth = 5.0
    return path
  }
  
  private enum Eye {
    case left
    case right
  }
  
  private func pathForEye(_ eye:Eye) -> UIBezierPath {
    
    func centerOfEye(_ eye:Eye) -> CGPoint {
      let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffSet
      var eyeCenter = skullCenter
      eyeCenter.y -= eyeOffset
      eyeCenter.x += ((eye == .left) ? -1:1) * eyeOffset
      return eyeCenter
    }
    
    let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
    let eyeCenter = centerOfEye(eye)
    
    let path: UIBezierPath
    
    if eyesOpen {
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
       path.fill()
      //lineWidth = 5.0
    }else  {
      path = UIBezierPath()
      path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
      path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
    }
    
    return path
  }
  
  
  private func pathForMouth() -> UIBezierPath {
    
    let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
    
    let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
    let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffSet
    
    let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
    
    let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
    
    let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
    let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
    
    let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset - 5)
    let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset - 5 )
    let path = UIBezierPath() //UIBezierPath(rect: mouthRect)
    path.move(to: start)
    print(start)
    print(cp1)
    print(cp2)
    print(end)
    path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
    path.lineWidth = lineWidth
    
    return path
  }
  
  
  private struct Ratios {
    
    static let skullRadiusToEyeOffSet:CGFloat = 3
    static let skullRadiusToEyeRadius:CGFloat = 10
    static let skullRadiusToMouthWidth:CGFloat = 1
    static let skullRadiusToMouthHeight:CGFloat = 3
    static let skullRadiusToMouthOffSet:CGFloat = 3
    
  }
  
  override func draw(_ rect: CGRect) {
    // Drawing code
    
    color.set()
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}
