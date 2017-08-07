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
  
  
  // 0~30  :  Good,             Heart,      Blue   , 좋음
  // 31~80 :  Moderate,         Smile,      Green  , 보통
  // 81~120:  Unhealthy,        Pokerface,  Orange , 약간나쁨
  // 121~200: Very Unhealthy,   Frown,       Red   , 나쁨
  // 201~300: Hazardous,        Awful,      Black  , 아주 나쁨

  // MARK : - Property
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var separatorView: UIView!
  var dustInfoList:[DustInfo]!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var indexLabel: UILabel!
  let pollutantType = ["PM10","O3","NO2","SO2","CO"]
  var frawnFace = AwfulFaceView()
  var faceAnimated = false
  let cellID = "pollutantInfoCollectionViewCell"
  let numberOfType = 5
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(dustInfoList)
    
    view.backgroundColor = UIColor.red
    collectionView.backgroundColor = UIColor.red

    indexLabel.text = dustInfoList[0].pm10Grade
    timeLabel.text = dustInfoList[0].timeObservation
    locationLabel.text = dustInfoList[0].locationName
    
    
    separatorView.backgroundColor = UIColor(colorLiteralRed: 179.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 1.0)
  
  
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
    return numberOfType
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PollutantInfoCollectionViewCell
  
    cell.contentView.backgroundColor = UIColor.red
    cell.pollutantTypeLabel.text = pollutantType[indexPath.row]
    cell.polltantInfo = dustInfoList[indexPath.row]
    
    switch indexPath.row {
    case 0:
      if #available(iOS 10.0, *) {
        cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].pm10Value) + "µg/m³" 
      } else {
        // Fallback on earlier versions
      }
      break
    case 1:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].o3Value) + "ppm"
      break
    case 2:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].no2Value) + "ppm"
      break
    case 3:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].so2Value) + "ppm"
      break
    case 4:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].coValue) + "ppm"
      break
    default:
      break
    }
    return cell
  }
  
  
}


// MARK : - PollutantInfoViewController : UICollectionViewDelegateFlowLayout

extension PollutantInfoViewController : UICollectionViewDelegateFlowLayout {

  // MARK : - UICollectionViewDelegateFlowLayout Method
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 80.0, height: 170.0)
  }
}


