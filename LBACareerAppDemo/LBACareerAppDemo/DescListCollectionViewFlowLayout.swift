//
//  DescListCollectionViewFlowLayout.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 7. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

class DescListCollectionViewFlowLayout: UICollectionViewFlowLayout {

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    let offset = collectionView!.contentOffset
    
    if offset.y < 0 {
      
      let deltaY = fabs(offset.y)
      
      for attribute in layoutAttributes! {
        
        if let elementKind = attribute.representedElementKind {
          
          if elementKind == UICollectionElementKindSectionHeader {
            var frame = attribute.frame
            frame.size.height = max(0, headerReferenceSize.height + deltaY)
            frame.origin.y = frame.minY - deltaY
            attribute.frame = frame
            
          }
        }
      }
    } else {
      
      for attribute in layoutAttributes! {
        
        if let elementKind = attribute.representedElementKind {
          if elementKind == UICollectionElementKindSectionHeader {
            var frame = attribute.frame
            frame.origin.y = frame.minY + offset.y
            attribute.frame = frame
            
          }
        }
      }
    }
    
    return layoutAttributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
