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
  
  private enum Mouth {
    case smile
    case frown
  }
  
  private func centerOfEye(_ eye:Eye) -> CGPoint {
    let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffSet
    var eyeCenter = skullCenter
    eyeCenter.y -= eyeOffset
    eyeCenter.x += ((eye == .left) ? -1:1) * eyeOffset
    return eyeCenter
  }
  
  private func pathForEye(_ eye:Eye) -> UIBezierPath {
    
    let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
    let eyeCenter = centerOfEye(eye)
    
    let path: UIBezierPath
    
    if eyesOpen {
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
      path.fill()
      
    }else  {
      path = UIBezierPath()
      path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
      path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
    }
    
    return path
  }
  
  
  
  private func pathForHeart(_ eye:Eye)-> UIBezierPath {
    
    func centerOfEye(_ eye:Eye) -> CGPoint {
      let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffSet
      var eyeCenter = skullCenter
      eyeCenter.y -= eyeOffset
      eyeCenter.x += ((eye == .left) ? -1:1) * eyeOffset
      return eyeCenter
    }
    
    
    let eyeCenter = centerOfEye(eye)
    let path: UIBezierPath
    
    print("eyeCenter : \(eyeCenter)")
    
    if eye == .left {
      path = UIBezierPath(heartIn: CGRect(x: self.bounds.origin.x + 10, y: self.bounds.origin.y + 20, width: 30, height: 30))
    } else {
      path = UIBezierPath(heartIn: CGRect(x: self.bounds.origin.x + 22, y: self.bounds.origin.y + 20, width: 30, height: 30))
    }
    
    path.fill()
    
    return path
  }
  
  private func pathForMouth() -> UIBezierPath {
    
    let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
    
    let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
    let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffSet
    
    let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
    
    let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
    
    
    // .frown
    let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
    let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
    
    let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset - 5)
    let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset - 5 )
    
    // smile
    
    //    let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY - 10)
    //    let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY - 10)
    //    let cp1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset + 28)
    //    let cp2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset + 28 )
    
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
  
  private func pathForFrown(_ eye: Eye) -> UIBezierPath {
    
    let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
    let eyeCenter = centerOfEye(eye)
    print("eyeRadius : \(eyeRadius)")
    let path: UIBezierPath
    print("pi : \(CGFloat.pi)")
    print("eyeCenter: \(eyeCenter)")
    
    if eye == .left {
      let angle = CGFloat.pi/8
      print("left start angle : \(angle)")
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius + 10, startAngle: CGFloat.pi/8, endAngle: CGFloat.pi , clockwise: true)
      path.fill()
      
    }else  {
      
      let angle = -CGFloat.pi/32
      print("right start angle : \(angle)")
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius + 10, startAngle:  angle, endAngle: CGFloat.pi - CGFloat.pi/8, clockwise: true)
      path.fill()
    }
    
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
    //pathForEye(.left).stroke()
    //pathForEye(.right).stroke()
    //pathForHeart(.left).stroke()
    //pathForHeart(.right).stroke()
    pathForMouth().stroke()
    
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    
  }
}

extension Int {
  var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}



extension UIBezierPath {
  
  
  convenience init(heartIn rect: CGRect) {
    
    self.init()
    
    
    //Calculate Radius of Arcs using Pythagoras
    let sideOne = rect.width * 0.4
    let sideTwo = rect.height * 0.3
    let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
    print("rect : \(rect)")
    print("origin: \(rect.origin)")
    let originX:CGFloat = rect.origin.x * 4
    let originY:CGFloat = rect.origin.y * 2
    
    //self.move(to: CGPoint(x: originX + 15, y: originY + 28.5))
    
    //Left Hand Curve
    self.addArc(withCenter: CGPoint(x: originX + rect.width * 0.3, y: originY + rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
    
    //Top Centre Dip
    self.addLine(to: CGPoint(x: originX + rect.width/2, y: originY + rect.height * 0.2))
    
    //Right Hand Curve
    self.addArc(withCenter: CGPoint(x: originX + rect.width * 0.7, y: originY + rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
    
    //Right Bottom Line
    self.addLine(to: CGPoint(x: originX + rect.width * 0.5, y: originY + rect.height * 0.95))
    
    //Left Bottom Line
    self.close()
  }
}

