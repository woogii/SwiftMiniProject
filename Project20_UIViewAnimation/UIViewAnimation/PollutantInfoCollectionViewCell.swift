//
//  PollutantInfoCollectionViewCell.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 6..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - PollutantInfoCollectionViewCell: UICollectionViewCell 

class PollutantInfoCollectionViewCell: UICollectionViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var pollutantTypeLabel: UILabel!
  @IBOutlet weak var pollutantLevelLabel: UILabel!
  let miniFaceViewFrame = CGRect(x: 15, y: 60, width: 40, height: 40)
  var faceViewColor:UIColor!
  
  var polltantInfo:DustInfo! {
    didSet {
      updateUI()
    }
  }
  
  // MARK : - Update Cell UI
  
  func updateUI() {
    
    // 0~30: 좋음, 31~80: 보통, 81~120: 약간나쁨, 121~200: 나쁨, 201~300: 매우나쁨
  
    let pm10Value = Int(polltantInfo.pm10Value)
    
    let faceView:FaceView = setFaceViewTypeBasedOnPM10Value(pm10Value)
    
    setFaceBackgroundColor(faceView: faceView)
    self.contentView.addSubview(faceView)
    animateMiniFaceView(faceView: faceView)
    
  }
  
  func animateMiniFaceView(faceView:FaceView) {
    faceView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    
    UIView.animate(withDuration: 0.7, animations: {
      faceView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }) { (finished) in
      
      UIView.animate(withDuration: 0.4, animations: {
        faceView.transform = CGAffineTransform.identity
      })
    }
  }
  
  func setFaceBackgroundColor(faceView:FaceView) {
    faceView.backgroundColor = faceViewColor
  }
  
  func setFaceViewTypeBasedOnPM10Value(_ pm10Value:Int)->FaceView {
    
    var faceView:FaceView!
    
    switch pm10Value {
      
    case Constants.GoodLevel:
      faceView = MiniHeartFaceView(frame:miniFaceViewFrame)
      break
      
    case Constants.ModerateLevel:
      faceView = MiniSmileFaceView(frame:miniFaceViewFrame)
      break
    case Constants.UnhealthyLevel:
      faceView = MiniPokerFaceView(frame:miniFaceViewFrame)
      break
    case Constants.VeryUnhealthyLevel:
      faceView = MiniFrownFaceView(frame:miniFaceViewFrame)
      break
    case Constants.HazardousLevel:
      faceView = MiniAwfulFaceView(frame:miniFaceViewFrame)
      break
    default:
      faceView = FaceView()
      break
    }

    return faceView
  }
  
  
}
