//
//  UIView+VisualFormat.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 9. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
// MARK : - UIView Extension
extension UIView {
  // MARK : - Add Constraints with VFL
  func addConstraintsWithFormat(format: String, views: UIView...) {
    var viewDictionary = [String: UIView]()
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                       options: NSLayoutFormatOptions(),
                                                       metrics: nil,
                                                       views: viewDictionary))
  }
}
