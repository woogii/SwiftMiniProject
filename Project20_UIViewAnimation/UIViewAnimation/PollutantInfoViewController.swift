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
  
  
  // 0~30  :  Good,             Heart,      Blue   
  // 31~80 :  Moderate,         Smile,      Green  
  // 81~120:  Unhealthy,        Pokerface,  Orange 
  // 121~200: Very Unhealthy,   Frown,       Red   
  // 201~300: Hazardous,        Awful,      Black

  // MARK : - Property
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var separatorView: UIView!
  var dustInfoList:[DustInfo]!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var indexLabel: UILabel!
  let pollutantType = ["PM10","O3","NO2","SO2","CO"]
  var mainFace:FaceView!
  var faceAnimated = false
  let cellID = "pollutantInfoCollectionViewCell"
  let numberOfType = 5
  let dateFormatter : DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_kr")
    dateFormatter.dateFormat = "yyyy.MM.dd h:mm a"
    dateFormatter.amSymbol = "am"
    dateFormatter.pmSymbol = "pm"
    
    return dateFormatter
  }()
  
  
  var themeColor:UIColor!
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let mainFaceFrame = CGRect(x: self.view.center.x - 160/2, y: -200, width: 160, height: 140)
    
    indexLabel.text = dustInfoList[0].pm10Grade
    timeLabel.text = dateFormatter.string(from:Date())
    locationLabel.text = dustInfoList[0].locationName
    
    let calculatedValue = Int(dustInfoList[0].pm10Value)
    
    switch calculatedValue {
      
    case 0...30:
      mainFace = HeartFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.blue
      view.backgroundColor = UIColor.blue
      collectionView.backgroundColor = UIColor.blue
      themeColor = UIColor.blue
      separatorView.backgroundColor = Constants.Colors.DarkBlue
      break
      
    case 31...80:
      mainFace = SmileFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.green
      separatorView.backgroundColor = Constants.Colors.DarkGreen
      themeColor = UIColor.red
      break
    case 81...120:
      mainFace = PokerFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.orange
      separatorView.backgroundColor = Constants.Colors.DarkOrange
      themeColor = UIColor.orange
      break
    case 121...200:
      
      mainFace = FrownFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.red
      separatorView.backgroundColor = Constants.Colors.DarkRed
      break
      
    case 201...300:
      mainFace = AwfulFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.red
      separatorView.backgroundColor = Constants.Colors.LightBlack
      break
    default:
      mainFace = FaceView()
      break
    }
    
    
  
    mainFace.isHidden = true
    view.addSubview(mainFace)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    mainFace.isHidden = false
    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
      
      self.mainFace.frame = CGRect(x: self.view.center.x - 160/2, y: 160, width: 160, height: 140)
  
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
  
    cell.pollutantTypeLabel.text = pollutantType[indexPath.row]
    cell.faceViewColor = themeColor
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


