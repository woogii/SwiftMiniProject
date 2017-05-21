//
//  SlideMenuCollectionViewCell.swift
//  SlideInMenu
//
//  Created by siwook on 2017. 5. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - SlideMenuCollectionViewCell : UICollectionViewCell

class SlideMenuCollectionViewCell : UICollectionViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var contentsView: UIView!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var typeLabel: UILabel!
  
  var menuInfo: MenuInfo! {
    didSet {
      updateCell()
    }
  }
  
  func updateCell() {
    
    if menuInfo.isSelected == true {
     contentsView.backgroundColor = Constants.CustomColors.PaleGrey
    } else {
      contentsView.backgroundColor = UIColor.white
    }
    
    iconImageView.image = UIImage(named:menuInfo.iconImageName) ?? UIImage()
    typeLabel.text = menuInfo.title

    
  }
}
