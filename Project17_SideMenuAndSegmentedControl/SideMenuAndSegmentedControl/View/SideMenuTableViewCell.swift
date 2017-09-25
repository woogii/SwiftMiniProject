//
//  SideMenuTableViewCell.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 2..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SideMenuTableViewCell: UITableViewCell

class SideMenuTableViewCell: UITableViewCell {

  // MARK : - Property

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var separatorView: UIView!
  @IBOutlet weak var menuIconImageView: UIImageView!

  @IBOutlet weak var syncDateLabel: UILabel!
  @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
  // MARK : - Nib File Loading

  override func awakeFromNib() {

    super.awakeFromNib()
    addCustomSelectedBackgroundView()
    setBackgroundColor()
    setMenuIconAndSyncDateLabelHiddenStatus()

  }

  private func setMenuIconAndSyncDateLabelHiddenStatus() {
    menuIconImageView.isHidden = true
    syncDateLabel.isHidden = true
  }

  private func setBackgroundColor() {
    backgroundColor = UIColor.clear
  }

  private func addCustomSelectedBackgroundView() {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    selectedBackgroundView = view

  }

  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    titleLabel.alpha = highlighted ? 0.5 : 1.0
  }

}
