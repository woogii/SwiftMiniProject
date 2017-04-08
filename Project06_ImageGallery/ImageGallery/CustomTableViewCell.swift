//
//  CustomTableViewCell.swift
//  ImageGallery
//
//  Created by siwook on 2017. 4. 8..
//  Copyright © 2017년 siwook. All rights reserved.
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
  
  func updateCell() {
    iconImageView.image = UIImage(named: restaurant.iconImageName)
    infoLabel.text = restaurant.info
  }
  
  
}

