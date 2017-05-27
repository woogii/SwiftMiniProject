//
//  CustomCollectionViewLayout.swift
//  PinterestStyleList
//
//  Created by siwook on 2017. 5. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CustomCollectionViewLayout: UICollectionViewLayout

class CustomCollectionViewLayout: UICollectionViewLayout {

  // MARK : - Property 
  var controller: ImageListViewController?
  var numberOfColumns:CGFloat = 2
  var cellPadding:CGFloat = 5.0
  
  private var contentHeight:CGFloat = 0.0
  private var contentWidth:CGFloat {
    let insets = collectionView!.contentInset
    return collectionView!.bounds.width - (insets.left + insets.right)
  }
  
  private var attributesCache = [UICollectionViewLayoutAttributes]()
  
  override func prepare() {
    
    if attributesCache.isEmpty {
      let columnWidth = contentWidth / numberOfColumns
      var xOffsets = [CGFloat]()
      
      for column in 0..<Int(numberOfColumns) {
        xOffsets.append(CGFloat(column) * columnWidth)
      }
      
      var column = 0
      var yOffsets = [CGFloat](repeating:0, count:Int(numberOfColumns))
      
      for item in 0..<collectionView!.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
        
        // calculate the frame
        
        let photoHeight:CGFloat = 0.0
        let captionHeight:CGFloat = 0.0
        
        let width = columnWidth - cellPadding * 2
        let height = cellPadding + photoHeight + captionHeight + cellPadding
        
        let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // create layout attributes 
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        attributesCache.append(attributes)
        
        // update column, yOffset
        contentHeight = max(contentHeight, frame.maxY)
        yOffsets[column] = yOffsets[column] + height
        
        if column >= (Int(numberOfColumns) - 1) {
          column = 0
        } else {
          column += 1
        }
        
      }
    }
  }
  
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in attributesCache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
}
