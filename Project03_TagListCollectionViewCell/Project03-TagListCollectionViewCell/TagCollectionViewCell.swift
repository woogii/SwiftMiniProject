//
//  TagCollectionViewCell.swift
//  Project03-TagListCollectionViewCell
//
//  Created by TeamSlogup on 2016. 10. 3..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - TagCollectionViewCell : UICollectionViewCell

class TagCollectionViewCell: UICollectionViewCell {
  
  // MARK : - Property
  
  @IBOutlet weak var keywordLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var containerViewMaxWidhtConstraint: NSLayoutConstraint!
  @IBOutlet weak var closeImageView: UIImageView!
  @IBOutlet weak var closeButton: UIButton!
  
  // MARK : - View Life Cycle
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    
    containerView.backgroundColor = UIColor.red
    containerView.layer.cornerRadius = 5
    containerViewMaxWidhtConstraint.constant = UIScreen.main.bounds.width
  }
  
}
