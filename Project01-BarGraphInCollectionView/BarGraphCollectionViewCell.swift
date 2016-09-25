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

    @IBOutlet weak var redBackgroundView: UIView!
    @IBOutlet weak var greenBackgroundView: UIView!
    @IBOutlet weak var blueBackgroundView: UIView!
    @IBOutlet weak var redValueView: UIView!
    @IBOutlet weak var greenValueView: UIView!
    @IBOutlet weak var blueValueView: UIView!
    @IBOutlet weak var redValueViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var greenValueViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueValueViewHeightConstraint: NSLayoutConstraint!
    
   
    var redBarGradientLayer:CAGradientLayer!
    var greenBarGradientLayer:CAGradientLayer!
    var blueBarGradientLayer:CAGradientLayer!
    
    override func awakeFromNib() {
        
        redBarGradientLayer = CAGradientLayer()
        greenBarGradientLayer = CAGradientLayer()
        blueBarGradientLayer = CAGradientLayer()
    
    }

    override func layoutSubviews() {
        
        
    }
}
