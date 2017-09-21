//
//  PostInformationTableViewCell.swift
//  RedditClone
//
//  Created by siwook on 2017. 4. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - PostInformationTableViewCell: UITableViewCell 

class PostInformationTableViewCell: UITableViewCell {

  // MARK : - Property 

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var upvoteCountLabel: UILabel!
  @IBOutlet weak var upvotesButton: UIButton!
  @IBOutlet weak var downvotesButton: UIButton!

  var upvoteTapAction: (() -> Void)?
  var downvoteTapAction: (() -> Void)?

  // MARK : - Property Observer

  var postInfo: PostInformation! {
    didSet {
      updateCell()
    }
  }

  // MARK : - Nib File Loading

  override func awakeFromNib() {
    super.awakeFromNib()

    setButtonsCornerRadius()
    setButtonsBorderColor()
  }

  private func setButtonsCornerRadius() {
    upvotesButton.layer.cornerRadius   = Constants.PostInformationTableViewCell.CornerRadius
    downvotesButton.layer.cornerRadius = Constants.PostInformationTableViewCell.CornerRadius
  }

  private func setButtonsBorderColor() {
    upvotesButton.layer.borderColor = UIColor.gray.cgColor
    downvotesButton.layer.borderColor = UIColor.gray.cgColor
  }

  // MARK : - Target Actions 

  @IBAction func tapUpvoteButton(_ sender: UIButton) {
    if let upvoteButtonAction = self.upvoteTapAction {
      upvoteButtonAction()
    }
  }

  @IBAction func tapDownvoteButton(_ sender: UIButton) {
    if let downvoteButtonAction = self.downvoteTapAction {
      downvoteButtonAction()
    }
  }

  // MARK : - Managing Cell Selection

  override func setSelected(_ selected: Bool, animated: Bool) {

    let color = self.contentView.backgroundColor // Store the color
    super.setSelected(isHighlighted, animated: animated)
    self.contentView.backgroundColor = color

  }

  // MARK : - Update Subviews  

  func updateCell() {

    titleLabel.text = postInfo.title
    upvoteCountLabel.text = String(postInfo.upvoteCount)
    postImageView.image = postInfo.postImage

  }

}
