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
  
  
  func updateUI() {
    
    // 0~30: 좋음, 31~80: 보통, 81~120: 약간나쁨, 121~200: 나쁨, 201~300: 매우나쁨
  
    let calculatedValue = Int(polltantInfo.pm10Value)
    
    var faceView:FaceView!
    

    switch calculatedValue {
      
    case 0...30:  
      faceView = MiniHeartFaceView(frame:miniFaceViewFrame)
      break
      
    case 31...80:
      faceView = MiniSmileFaceView(frame:miniFaceViewFrame)
      break
    case 81...120:
      faceView = MiniPokerFaceView(frame:miniFaceViewFrame)
      break
    case 121...200:
      faceView = MiniFrownFaceView(frame:miniFaceViewFrame)
      break
      
    case 201...300:
      faceView = MiniAwfulFaceView(frame:miniFaceViewFrame)
      break
    default:
      faceView = FaceView()
      break
    }
    
    faceView.backgroundColor = faceViewColor
    
    self.contentView.addSubview(faceView)
    faceView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    
    UIView.animate(withDuration: 0.7, animations: {
        faceView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }) { (finished) in
        
      UIView.animate(withDuration: 0.4, animations: {
          faceView.transform = CGAffineTransform.identity
        })
    }

  }
  
  
}
