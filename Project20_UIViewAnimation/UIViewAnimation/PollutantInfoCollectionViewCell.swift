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
  
  @IBOutlet weak var timeInfoLabel: UILabel!
  @IBOutlet weak var pollutantLevelLabel: UILabel!
  let miniFaceViewFrame = CGRect(x: 20, y: 60, width: 40, height: 40)
  
  var polltantInfo:DustInfo! {
    didSet {
      updateUI()
    }
  }
  
  
  func updateUI() {
    
    //self.backgroundColor = UIColor.red
    
    // 0~30: 좋음, 31~80: 보통, 81~120: 약간나쁨, 121~200: 나쁨, 201~300: 매우나쁨
    let valueString = polltantInfo.value.components(separatedBy: ".")[0]

    guard let calculatedValue = Int(valueString) else {
      return
    }
    
    var faceView:FaceView!
    
    switch calculatedValue {
      
    case 0...30:  
      faceView = MiniHeartFaceView(frame:miniFaceViewFrame)
      faceView.backgroundColor = UIColor.red

      break
      
    case 31...80:
      faceView = MiniSmileFaceView(frame:miniFaceViewFrame)
      faceView.backgroundColor = UIColor.red

      break
    case 81...120:
      faceView = MiniPokerFaceView(frame:miniFaceViewFrame)
      faceView.backgroundColor = UIColor.red
      
      break
    case 121...200:
      
      faceView = MiniFrownFaceView(frame:miniFaceViewFrame)
      faceView.backgroundColor = UIColor.red
      break
      
    case 201...300:
      faceView = MiniAwfulFaceView(frame:miniFaceViewFrame)
      faceView.backgroundColor = UIColor.red
      break
    default:
      faceView = FaceView()
      faceView.lineWidth = 3
      faceView.backgroundColor = UIColor.red
      faceView.frame = CGRect(x: 20, y: 60, width: 40, height: 40)
      break
    }
    
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
