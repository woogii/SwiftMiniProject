//
//  BarGraphCollectionViewCell.swift
//  Project01-BarGraphInCollectionView
//
//  Created by TeamSlogup on 2016. 9. 25..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - BarGraphCollectionViewCell: UICollectionViewCell

class BarGraphCollectionViewCell: UICollectionViewCell {
  
  // MARK : - Property 
  
  @IBOutlet weak var redBackgroundView: UIView!
  @IBOutlet weak var greenBackgroundView: UIView!
  @IBOutlet weak var blueBackgroundView: UIView!
  @IBOutlet weak var redValueView: UIView!
  @IBOutlet weak var greenValueView: UIView!
  @IBOutlet weak var blueValueView: UIView!
  @IBOutlet weak var redValueViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var greenValueViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var blueValueViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var redBarFigureLabel: UILabel!
  @IBOutlet weak var greenBarFigureLabel: UILabel!
  @IBOutlet weak var blueBarFigureLabel: UILabel!
  
  let ratioValueToMax:[[Float]] = [[0.6,0.7,0.8],[0.3,0.5,0.9],[0.6,0.8,0.4],[0.7,0.2,0.6],[0.6,0.3,0.2]]
  let cellBackgroundHeight:Float = 221.0
  let redColors = [UIColor(red: 103.0/255.0, green: 178.0/255.0, blue: 111.0/255.0, alpha: 1.0),UIColor(red: 76.0/255.0, green: 162.0/255.0, blue: 205.0/255.0, alpha: 1.0)]
  let greenColors = [UIColor(red: 238.0/255.0, green: 9.0/255.0, blue: 121.0/255.0, alpha: 1.0),UIColor(red: 255.0/255.0, green: 106.0/255.0, blue: 0.0/255.0, alpha: 1.0)]
  let blueColors = [UIColor(red: 255.0/255.0, green: 252.0/255.0, blue: 0.0/255.0, alpha: 1.0), UIColor.white]
  var redBarGradientLayer = CAGradientLayer()
  var greenBarGradientLayer = CAGradientLayer()
  var blueBarGradientLayer = CAGradientLayer()
  var figureSuffix = "%"
  
  func configureCell(indexPath:IndexPath) {
    
    removeGradientLayersFromValueBarGraphs()
    initializeValueBarGraphsHeightConstraints()
    configureGradientLayersForValueGraphs()
    addGradientLayersForValueGraphs()
    setFigureText(indexPath: indexPath)
    animateValues(indexPath: indexPath)
  }
  
  
  func initializeValueBarGraphsHeightConstraints() {
    redValueViewHeightConstraint.constant = 0.0
    greenValueViewHeightConstraint.constant = 0.0
    blueValueViewHeightConstraint.constant = 0.0
  }
  
  func removeGradientLayersFromValueBarGraphs() {
    
    if let _ = redValueView.layer.sublayers {
      redBarGradientLayer.removeFromSuperlayer()
    }
    
    if let _ = greenValueView.layer.sublayers {
      redBarGradientLayer.removeFromSuperlayer()
    }
    
    if let _ = blueValueView.layer.sublayers {
    blueBarGradientLayer.removeFromSuperlayer()
    }
    
  }
  
  func setFigureText(indexPath:IndexPath) {
    redBarFigureLabel.text   = String(ratioValueToMax[indexPath.row][0] * 100) + figureSuffix
    greenBarFigureLabel.text = String(ratioValueToMax[indexPath.row][1] * 100) + figureSuffix
    blueBarFigureLabel.text  = String(ratioValueToMax[indexPath.row][2] * 100) + figureSuffix
  }
  
  func configureGradientLayersForValueGraphs() {
    
    redBarGradientLayer.colors = [redColors[0].cgColor, redColors[1].cgColor]
    redBarGradientLayer.locations = [0.0, 1.0]
    redBarGradientLayer.frame =  redBackgroundView.layer.bounds
    redBarGradientLayer.masksToBounds = true
    
    greenBarGradientLayer.colors = [greenColors[0].cgColor, greenColors[1].cgColor]
    greenBarGradientLayer.locations = [0.0, 1.0]
    greenBarGradientLayer.frame = greenBackgroundView.layer.bounds
    greenBarGradientLayer.masksToBounds = true
    
    
    blueBarGradientLayer.colors = [blueColors[0].cgColor, blueColors[1].cgColor]
    blueBarGradientLayer.locations = [0.0, 1.0]
    blueBarGradientLayer.frame = blueBackgroundView.layer.bounds
    blueBarGradientLayer.masksToBounds = true
    
  }
  
  func addGradientLayersForValueGraphs() {
    
    redValueView.layer.addSublayer(redBarGradientLayer)
    greenValueView.layer.addSublayer(greenBarGradientLayer)
    blueValueView.layer.addSublayer(blueBarGradientLayer)
    
  }
  
  func animateValues(indexPath:IndexPath) {
    
    let delay:Double = 0.1
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: time){
      
      UIView.animate(withDuration: 0.8, animations: {
        self.redValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[indexPath.row][0] * self.cellBackgroundHeight )
        self.greenValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[indexPath.row][1] * self.cellBackgroundHeight )
        self.blueValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[indexPath.row][2] * self.cellBackgroundHeight )
        
        self.layoutIfNeeded()
      })
    }
    
    
    
  }

  
}
