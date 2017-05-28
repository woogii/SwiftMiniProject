//
//  CustomCollectionViewLayoutAttributes.swift
//  PinterestStyleList
//
//  Created by siwook on 2017. 5. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CustomCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

class CustomCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
  
  // MARK : - Property
  
  var photoHeight:CGFloat = 0.0
  
  override func copy(with zone: NSZone? = nil) -> Any {
    let copy = super.copy(with: zone) as! CustomCollectionViewLayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    if let attributes = object as? CustomCollectionViewLayoutAttributes {
      if attributes.photoHeight == photoHeight {
        return super.isEqual(object)
      }
    }
    
    return false
  }
}
