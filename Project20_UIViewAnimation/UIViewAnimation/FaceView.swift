//
//  FaceView.swift
//  UIViewAnimation
//
//  Source from Standford CS 193p
//  https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120

import UIKit

// MARK : - FaceView: UIView

class FaceView: UIView {
  
  
  var scale:CGFloat = 0.9
  var eyesOpen : Bool = true
  var lineWidth: CGFloat = 5.0
  var color: UIColor = UIColor.white
  
  var mouthCurvature : Double = 1.0  // 1.0 is full smile and -1.0 is full frown
                                     // 0.2 poker face
  var scaleFactorHeartSize:CGFloat = 1
  let heartSize:CGFloat = 40
  var scaleFactorForHeartEye:CGFloat = 1
  var heartEyeOffset:CGFloat = 0
  
  private var skullRadius : CGFloat {
    return min(bounds.size.width, bounds.size.height)/2 * scale
  }
  
  private var skullCenter : CGPoint {
    return CGPoint(x:bounds.midX, y:bounds.midY)
  }
  
  fileprivate func pathForSkull() -> UIBezierPath {
    let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
    
    path.lineWidth = lineWidth
    
    return path
  }
  
  fileprivate enum Eye {
    case left
    case right
  }
  
  fileprivate enum Mouth {
    case smile
    case frown
    case pokerFace
  }
  
  fileprivate func centerOfEye(_ eye:Eye) -> CGPoint {
    let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffSet
    var eyeCenter = skullCenter
    eyeCenter.y -= eyeOffset
    eyeCenter.x += ((eye == .left) ? -1:1) * eyeOffset
    return eyeCenter
  }
  
  fileprivate func pathForEye(_ eye:Eye) -> UIBezierPath {
    
    let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
    let eyeCenter = centerOfEye(eye)
    
    let path: UIBezierPath
    
    if eyesOpen {
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
      
    }else  {
      path = UIBezierPath()
      path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
      path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
    }
    path.lineWidth = lineWidth
    path.fill()
    
    return path
  }

  fileprivate func pathForHeart(_ eye:Eye)-> UIBezierPath {
    
    func startPointOfEye(_ eye:Eye) -> CGPoint {
      
      var startPoint = CGPoint(x:10 - heartEyeOffset, y: 20 - (heartEyeOffset*2))
      startPoint.x += ((eye == .left) ? 0: 10 - heartEyeOffset)
      
      return startPoint
    }
    
    
    let startPoint = startPointOfEye(eye)
    let path: UIBezierPath
    
    print("startPoint : \(startPoint)")
    print("bounds : \(bounds)")
    
    let heartWidth  = heartSize / scaleFactorHeartSize
    let heartHeight = heartSize / scaleFactorHeartSize
   
    path = UIBezierPath(heartIn: CGRect(x: startPoint.x, y: startPoint.y, width: heartWidth, height: heartHeight))
    
    path.fill()
    
    return path
  }
  
  fileprivate func pathForMouth() -> UIBezierPath {
    
    let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
    
    let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
    let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffSet
    
    let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
    
    let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
    
    
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
  
  fileprivate func pathForFrown(_ eye: Eye) -> UIBezierPath {
    
    let eyeRadius = skullRadius / 3//Ratios.skullRadiusToEyeRadius
    let eyeCenter = centerOfEye(eye)
    let path: UIBezierPath
   

    if eye == .left {
      let angle = CGFloat.pi/8
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: angle, endAngle: CGFloat.pi , clockwise: true)
    
    }else  {
      
      let angle = -CGFloat.pi/32
      path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle:  angle, endAngle: CGFloat.pi - CGFloat.pi/8, clockwise: true)
      
    }
    path.fill()
    
    return path
  
  }
  

  struct Ratios {
    static let skullRadiusToEyeOffSet:CGFloat = 3
    static let skullRadiusToEyeRadius:CGFloat = 6 // 10
    static let skullRadiusToMouthWidth:CGFloat = 1
    static let skullRadiusToMouthHeight:CGFloat = 3
    static let skullRadiusToMouthOffSet:CGFloat = 3
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

// MARK : - FrownFaceView: UIView

class FrownFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    color.set()
    pathForSkull().stroke()
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    pathForMouth().stroke()
  }
}

// MARK : - HeartFaceView : UIView

class HeartFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForHeart(.left).stroke()
    pathForHeart(.right).stroke()
    pathForMouth().stroke()
  }
}

// MARK : - SmileView : UIView

class SmileView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    color.set()
    mouthCurvature = 1.0
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}

// MARK : - AwfulFaceView : UIView

class AwfulFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForFrown(.left).stroke()
    pathForFrown(.right).stroke()
    pathForMouth().stroke()
  }
}



// MARK : - PokerFaceView : UIView

class PokerFaceView : FaceView {
  
  override func draw(_ rect: CGRect) {
    
    super.draw(rect)
    
    drawSkullAndHeart()
  }
  
  private func drawSkullAndHeart() {
    pathForSkull().stroke()
    pathForEye(.left).stroke()
    pathForEye(.right).stroke()
    pathForMouth().stroke()
  }
}



// MARK : - Extension : Int

extension Int {
  var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}


// MARK : - Extension : UIBezierPath 

extension UIBezierPath {
  
  
  convenience init(heartIn rect: CGRect) {
    
    self.init()
    
    
    //Calculate Radius of Arcs using Pythagoras
    let sideOne = rect.width * 0.4
    let sideTwo = rect.height * 0.3
    let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
    //print("rect : \(rect)")
    //print("origin: \(rect.origin)")
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

