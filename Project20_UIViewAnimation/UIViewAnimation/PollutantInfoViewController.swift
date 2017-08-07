//
//  ViewController.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController

class PollutantInfoViewController: UIViewController {
  
  // 0~30: 좋음, 31~80: 보통, 81~120: 약간나쁨, 121~200: 나쁨, 201~300: 매우나쁨
  // Good :    Heart Blue,
  // Moderate : 스마일 Green
  // Unhealthy : 입술 가로 Orange  
  // Very Unhealthy: Red 
  // Hazardous : 찡그림  Black

  // MARK : - Property
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var separatorView: UIView!
  var dustInfoList:[DustInfo]!

  var frawnFace = FrownFaceView()
  var faceAnimated = false
  let cellID = "pollutantInfoCollectionViewCell"
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(dustInfoList)
    view.backgroundColor = UIColor.red
    collectionView.backgroundColor = UIColor.red
    frawnFace.backgroundColor = UIColor.red
    separatorView.backgroundColor = UIColor(colorLiteralRed: 179.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 1.0)
    frawnFace.lineWidth = 10
  
    frawnFace.backgroundColor = UIColor.red
    
    frawnFace.isHidden = true
    frawnFace.frame = CGRect(x: self.view.center.x - 160/2, y: -200, width: 160, height: 140)
  
    view.addSubview(frawnFace)

    
  }
  
   
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    frawnFace.isHidden = false
    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
      
      
      self.frawnFace.frame = CGRect(x: self.view.center.x - 160/2, y: 160, width: 160, height: 140)
    
    
    }, completion: nil)
    
  }
  
  
}

// MARK : - PollutantInfoViewController : UICollectionViewDataSource

extension PollutantInfoViewController : UICollectionViewDataSource {
  
  // MARK : - UICollectionViewDataSource Methods
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PollutantInfoCollectionViewCell
  
    ///cell.faceView.lineWidth = 2
    //cell.faceView.drawFrown()
    cell.contentView.backgroundColor = UIColor.red
    //cell.faceView.backgroundColor = UIColor.red
    
    cell.polltantInfo = dustInfoList[indexPath.row]
//    if !faceAnimated {
//  
//      //cell.faceView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1
//    UIView.animate(withDuration: 0.7, animations: {
//      //cell.faceView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//    }) { (finished) in
//      
//      UIView.animate(withDuration: 0.4, animations: {
//        //cell.faceView.transform = CGAffineTransform.identity
//        self.faceAnimated = true
//      })
//    }
    
      
//    }
    
    return cell
  }
  
  
}


// MARK : - PollutantInfoViewController : UICollectionViewDelegateFlowLayout

extension PollutantInfoViewController : UICollectionViewDelegateFlowLayout {

  // MARK : - UICollectionViewDelegateFlowLayout Method
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 70.0, height: 170.0)
  }
}


