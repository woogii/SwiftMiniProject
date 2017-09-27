//
//  ImageEditTypeCell.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - ImageEditTypeCell: UICollectionViewCell
class ImageEditTypeCell: UICollectionViewCell {
  // MARK : - Property
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ?  UIColor.lightGray : UIColor.white
    }
  }
  let editTypeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 15.0)
    label.textColor = UIColor.black
    return label
  }()
  let separatorview: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(colorLiteralRed: 200/255, green: 199/255, blue: 204/255, alpha: 1.0)
    return view
  }()
  // MARK : - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(editTypeLabel)
    addSubview(separatorview)
    let leading: CGFloat = self.frame.size.width*0.36
    editTypeLabel.translatesAutoresizingMaskIntoConstraints = false
    separatorview.translatesAutoresizingMaskIntoConstraints = false
    let labelH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leading)-[v0]|",
      options: NSLayoutFormatOptions(),
      metrics: nil,
      views: ["v0": editTypeLabel])
    let labelV = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|",
                                                options: NSLayoutFormatOptions(),
                                                metrics: nil,
                                                views: ["v0": editTypeLabel])
    let viewH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|",
                                               options: NSLayoutFormatOptions(),
                                               metrics: nil,
                                               views: ["v0": separatorview])
    let viewV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-59-[v0(1)]-0-|",
                                               options: NSLayoutFormatOptions(),
                                               metrics: nil,
                                               views: ["v0": separatorview])
    for constraint in viewV {
      constraint.identifier = "$View Vertical$"
    }
    addConstraints(viewV)
    addConstraints(viewH)
    addConstraints(labelV)
    addConstraints(labelH)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
