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
  var redBarGradientLayer = CAGradientLayer()
  var greenBarGradientLayer = CAGradientLayer()
  var blueBarGradientLayer = CAGradientLayer()
  var ratioValue: RatioValue! {
    didSet {
      updateUI()
    }
  }
  private func updateUI() {
    removeGradientLayersFromValueBarGraphs()
    initializeValueBarGraphsHeightConstraints()
    configureGradientLayersForValueGraphs()
    addGradientLayersForValueGraphs()
    setFigureText()
    animateValues()
  }
  private func initializeValueBarGraphsHeightConstraints() {
    redValueViewHeightConstraint.constant = 0.0
    greenValueViewHeightConstraint.constant = 0.0
    blueValueViewHeightConstraint.constant = 0.0
  }
  private func removeGradientLayersFromValueBarGraphs() {
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
  private func setFigureText() {
    redBarFigureLabel.text   = String(ratioValue.firstValue * 100) + Constants.FigureSuffix
    greenBarFigureLabel.text = String(ratioValue.secondValue * 100) + Constants.FigureSuffix
    blueBarFigureLabel.text  = String(ratioValue.thirdValue * 100) + Constants.FigureSuffix
  }
  private func configureGradientLayersForValueGraphs() {
    redBarGradientLayer.colors = [Constants.Colors.DarkRed.cgColor,
                                  Constants.Colors.LightRed.cgColor]
    redBarGradientLayer.locations = [0.0, 1.0]
    redBarGradientLayer.frame =  redBackgroundView.layer.bounds
    redBarGradientLayer.masksToBounds = true
    greenBarGradientLayer.colors = [Constants.Colors.DrakGreen.cgColor,
                                    Constants.Colors.LightGreen.cgColor]
    greenBarGradientLayer.locations = [0.0, 1.0]
    greenBarGradientLayer.frame = greenBackgroundView.layer.bounds
    greenBarGradientLayer.masksToBounds = true
    blueBarGradientLayer.colors = [Constants.Colors.Blue.cgColor,
                                   UIColor.white.cgColor]
    blueBarGradientLayer.locations = [0.0, 1.0]
    blueBarGradientLayer.frame = blueBackgroundView.layer.bounds
    blueBarGradientLayer.masksToBounds = true
  }
  private func addGradientLayersForValueGraphs() {
    redValueView.layer.addSublayer(redBarGradientLayer)
    greenValueView.layer.addSublayer(greenBarGradientLayer)
    blueValueView.layer.addSublayer(blueBarGradientLayer)
  }
  private func animateValues() {
    let delay: Double = 0.1
    let time = DispatchTime.now() +
      Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline:  time) {
      UIView.animate(withDuration: 0.8, animations: {
        self.redValueViewHeightConstraint.constant =
          CGFloat( self.ratioValue.firstValue * Constants.CellBackgroundHeight )
        self.greenValueViewHeightConstraint.constant =
          CGFloat( self.ratioValue.secondValue * Constants.CellBackgroundHeight )
        self.blueValueViewHeightConstraint.constant =
          CGFloat( self.ratioValue.thirdValue * Constants.CellBackgroundHeight )
        self.layoutIfNeeded()
      })
    }
  }
}
