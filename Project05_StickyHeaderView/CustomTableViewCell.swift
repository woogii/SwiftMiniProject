//
//  CustomTableViewCell.swift
//  StickyHeaderViewDemo
//
//  Created by siwook on 2017. 4. 1..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - CustomTableViewCell: UITableViewCell

class CustomTableViewCell: UITableViewCell {

  // MARK : - Property
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var infoLabel: UILabel!
  
  var restaurant : RestaurantInfo! {
    didSet {
      updateCell()
    }
  }
  
  // MARK : - Update Cell UI 
  
  func updateCell() {
    iconImageView.image = UIImage(named: restaurant.iconImageName)
    infoLabel.text = restaurant.description
  }
  
 
}
