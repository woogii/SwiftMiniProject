/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

//
//  CustomCollectionViewLayout.swift
//  PinterestStyleList
//
//  Created by siwook on 2017. 5. 27..
//  Based on the code in the free tutorial from raywenderlich.com


import UIKit

// MARK : - CustomLayoutDelegate

protocol CustomLayoutDelegate {
  
  func collectionView(collectionView:UICollectionView, heightForPhotoAt indexPath:IndexPath, with width:CGFloat)->CGFloat
  
  func collectionView(collectionView:UICollectionView, heightForCaptionAt indexPath:IndexPath, with width:CGFloat)->CGFloat
}

// MARK : - CustomCollectionViewLayout: UICollectionViewLayout

class CustomCollectionViewLayout: UICollectionViewLayout {
  
  // MARK : - Property
  var controller: ImageListViewController?
  var numberOfColumns:CGFloat = 2
  var cellPadding:CGFloat = 1.0
  var delegate : CustomLayoutDelegate?
  private var contentHeight:CGFloat = 0.0
  private var contentWidth:CGFloat {
    let insets = collectionView!.contentInset
    return collectionView!.bounds.width - (insets.left + insets.right)
  }
  private var customAttributes = [CustomCollectionViewLayoutAttributes]()
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  
  override func prepare() {
    
    customAttributes = []
    
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
      
      let width = columnWidth - cellPadding * 2
      
      let photoHeight:CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForPhotoAt: indexPath, with: width))!
      let captionHeight:CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForCaptionAt: indexPath, with: width))!
      
      
      let height = cellPadding + photoHeight + captionHeight + cellPadding
      
      let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      // create layout attributes
      let attributes = CustomCollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.photoHeight = photoHeight
      attributes.frame = insetFrame
      
      customAttributes.append(attributes)
      
      
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
  
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in customAttributes {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    
    return customAttributes.first(where: { attributes -> Bool in
      return attributes.indexPath == indexPath
    })
    
  }
  
  
}


