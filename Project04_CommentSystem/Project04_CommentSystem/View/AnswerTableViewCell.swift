//
//  AnswerTableViewCell.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2017. 3. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

  // MARK : - Property
  
  @IBOutlet weak var replyIndicatorImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var answerLabel: UILabel!

  override func awakeFromNib() {
    
    super.awakeFromNib()
    
    setCornerRadiusForProfile()
  }
  
  func setCornerRadiusForProfile() {
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    profileImageView.layer.masksToBounds = true 
  }
  
  var answerComment : Comment! {
    didSet {
      updateCell()
    }
  }
  
  func updateCell() {
    answerLabel.text = answerComment.text
    profileImageView.image = UIImage(named:"profile2")
  }
  
  
}


