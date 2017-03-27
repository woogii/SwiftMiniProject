//
//  CommentTableViewCell.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2017. 3. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - CommentTableViewCell: UITableViewCell

class CommentTableViewCell: UITableViewCell {

  // MARK : - Property 
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var commentLabel: UILabel!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    setCornerRadiusForProfile()
  }
  
  func setCornerRadiusForProfile() {
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    profileImageView.layer.masksToBounds = true 
  }
  
  var questionComment : Comment! {
    didSet {
      updateCell()
    }
  }

  func updateCell() {
    commentLabel.text = questionComment.text
    profileImageView.image = UIImage(named:"profile1")
  }
  
}


