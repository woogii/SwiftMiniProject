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

  // MARK : - Property

  @IBOutlet weak var locationLabel: UILabel!

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var separatorView: UIView!
  var dustInfoList: [DustInfo]!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var indexLabel: UILabel!
  let pollutantType = ["PM10", "O3", "NO2", "SO2", "CO"]
  var mainFace: FaceView!
  var faceAnimated = false
  let cellID = "pollutantInfoCollectionViewCell"
  let numberOfType = 5
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_kr")
    dateFormatter.dateFormat = "yyyy.MM.dd h:mm a"
    dateFormatter.amSymbol = "am"
    dateFormatter.pmSymbol = "pm"

    return dateFormatter
  }()
  var themeColor: UIColor!
  let cellWidth: CGFloat = 80
  let cellHeight: CGFloat = 170
  let mainFaceXPositionAdjustment: CGFloat = 80
  let mainFaceInitialPosition: CGFloat = -200
  let mainFaceAfterPosition: CGFloat = 200
  let mainFaceWidth: CGFloat = 160
  let mainFaceHeight: CGFloat = 140

  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    indexLabel.text = dustInfoList[0].pm10Grade
    timeLabel.text = dateFormatter.string(from:Date())
    locationLabel.text = dustInfoList[0].locationName

    let pm10Value = Int(dustInfoList[0].pm10Value)
    setFaceViewTypeBasedOnPM10Value(pm10Value)

    mainFace.isHidden = true
    view.addSubview(mainFace)
  }

  func setFaceViewTypeBasedOnPM10Value(_ pm10Value: Int) {

    let mainFaceFrame = CGRect(x: self.view.center.x - mainFaceXPositionAdjustment,
                               y: mainFaceInitialPosition,
                               width: mainFaceWidth, height: mainFaceHeight)

    switch pm10Value {

    case Constants.GoodLevel:
      mainFace = HeartFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.blue
      view.backgroundColor = UIColor.blue
      collectionView.backgroundColor = UIColor.blue
      themeColor = UIColor.blue
      separatorView.backgroundColor = Constants.Colors.DarkBlue
      break

    case Constants.ModerateLevel:
      mainFace = SmileFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.green
      separatorView.backgroundColor = Constants.Colors.DarkGreen
      themeColor = UIColor.red
      break
    case Constants.UnhealthyLevel:
      mainFace = PokerFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.orange
      separatorView.backgroundColor = Constants.Colors.DarkOrange
      themeColor = UIColor.orange
      break

    case Constants.VeryUnhealthyLevel:
      mainFace = AwfulFaceView(frame:mainFaceFrame)
      mainFace.backgroundColor = UIColor.red
      separatorView.backgroundColor = Constants.Colors.LightBlack
      break

    default:
      mainFace = FaceView()
      break
    }

  }

  override func viewDidAppear(_ animated: Bool) {

    super.viewDidAppear(animated)

    hideMainFace()
    animateMainFace()

  }

  func hideMainFace() {
    mainFace.isHidden = false
  }

  func animateMainFace() {

    UIView.animate(withDuration: 1.0, delay: 0.0,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 5, options: .curveEaseInOut, animations: {

      self.mainFace.frame = CGRect(x: self.view.center.x - self.mainFaceXPositionAdjustment,
                                   y: self.mainFaceAfterPosition,
                                   width: self.mainFaceWidth,
                                   height: self.mainFaceHeight)

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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                      for: indexPath) as? PollutantInfoCollectionViewCell else {
      return UICollectionViewCell()
    }

    configureCell(cell, indexPath: indexPath)

    return cell
  }

  func configureCell(_ cell: PollutantInfoCollectionViewCell, indexPath: IndexPath) {

    cell.pollutantTypeLabel.text = pollutantType[indexPath.row]
    cell.faceViewColor = themeColor
    cell.polltantInfo = dustInfoList[indexPath.row]

    switch indexPath.row {
    case 0:
      if #available(iOS 10.0, *) {
        cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].pm10Value) + Constants.MicroGram

      } else {
        // Fallback on earlier versions
      }
      break
    case 1:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].o3Value) + Constants.PartsPerMillion
      break
    case 2:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].no2Value) + Constants.PartsPerMillion
      break
    case 3:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].so2Value) + Constants.PartsPerMillion
      break
    case 4:
      cell.pollutantLevelLabel.text = String(dustInfoList[indexPath.row].coValue) + Constants.PartsPerMillion
      break
    default:
      break
    }

  }
}

// MARK : - PollutantInfoViewController : UICollectionViewDelegateFlowLayout

extension PollutantInfoViewController : UICollectionViewDelegateFlowLayout {

  // MARK : - UICollectionViewDelegateFlowLayout Method

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: 80.0, height: 170.0)
  }
}
