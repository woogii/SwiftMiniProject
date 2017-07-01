//
//  BookItemTableViewCell.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 6. 30..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - BookItemTableViewCell: UITableViewCell

class BookItemTableViewCell: UITableViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var bookCoverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet var downloadIndicatorImageView: UIImageView!
  @IBOutlet var circleViews:[UIView]!
  
  // MARK : - Nib file loading 
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    for view in circleViews {
      view.layer.cornerRadius = view.frame.size.width/2
    }
  }

  

}
