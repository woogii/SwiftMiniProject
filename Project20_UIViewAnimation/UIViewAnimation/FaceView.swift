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
      //path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
      
      let rect = CGRect(x: eyeCenter.x, y: eyeCenter.y , width: 40, height: 40)
      
      //path = UIBezierPath(rect: rect)
      path = UIBezierPath()
      path.move(to: CGPoint(x: eyeCenter.x - 10, y: eyeCenter.y + 20))
      // path.move(to:eyeCenter)
      
      print(rect)
      let sideOne = rect.width * 0.4
      let sideTwo = rect.height * 0.3
      let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
      
      // Left Hand Curve
      path.addArc(withCenter: CGPoint(x: rect.width * 1.0, y: rect.height * 0.55 ), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
      
      //Top Centre Dip
      path.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.4))
      
      //Right Hand Curve
      path.addArc(withCenter: CGPoint(x: rect.width * 1.4, y: rect.height * 0.55), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
      
      //Right Bottom Line
      path.addLine(to: CGPoint(x: rect.width * 1.2, y: rect.height * 1.25))
      
  
//      path.addArc(withCenter: CGPoint(x: rect.width * 0.6, y: rect.height * 0.35 ), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
//      
//      //Top Centre Dip
//      path.addLine(to: CGPoint(x: rect.width, y: rect.height))
//      
//      //Right Hand Curve
//      path.addArc(withCenter: CGPoint(x: rect.width , y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
//      
//      //Right Bottom Line
//      path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.95))
//
      path.close()
      //path.fill()
      
      
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
    
    // let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
    // let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
    
    //let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset - 5)
    //let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset - 5 )
    
    let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY - 10)
    let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY - 10)
    let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset + 28)
    let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset + 28 )
    
    let path = UIBezierPath() //UIBezierPath(rect: mouthRect)
    path.move(to: start)
//    print(start)
//    print(cp1)
//    print(cp2)
//    print(end)
    path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
    path.lineWidth = lineWidth
    
    return path
  }
  
  
  private struct Ratios {
    
    static let skullRadiusToEyeOffSet:CGFloat = 3
    static let skullRadiusToEyeRadius:CGFloat = 6 //10
    static let skullRadiusToMouthWidth:CGFloat = 1
    static let skullRadiusToMouthHeight:CGFloat = 3
    static let skullRadiusToMouthOffSet:CGFloat = 3
    
  }
  
  override func draw(_ rect: CGRect) {
    // Drawing code
    
    color.set()
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    //pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}

extension Int {
  var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
