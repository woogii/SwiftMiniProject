//
//  UIView+VisualFormat.swift
//  Project04_CommentSystem
//
//  Created by siwook on 2017. 8. 24..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit


extension UIView {
  
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
