//
//  DescListCollectionViewFlowLayout.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 7. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - DescListCollectionViewFlowLayout: UICollectionViewFlowLayout

class DescListCollectionViewFlowLayout: UICollectionViewFlowLayout {

  // MARK : - Property

  var deleteIndexPaths = [IndexPath]()

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

    // reference : https://www.youtube.com/watch?v=faUirawzPaY

    let layoutAttributes = super.layoutAttributesForElements(in:rect)?.map({ (layoutAttributes)
                                                                -> UICollectionViewLayoutAttributes in
      guard let attribute = layoutAttributes.copy() as? UICollectionViewLayoutAttributes else {
        return UICollectionViewLayoutAttributes()
      }
      return attribute
    })

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

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

    let attributes = super.layoutAttributesForItem(at: indexPath)
    return attributes
  }

  override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath)
                                                      -> UICollectionViewLayoutAttributes? {

    // reference : https://github.com/mpospese/CircleLayout/blob/master/CircleLayout/CircleLayout.m
    // https://stackoverflow.com/questions/13498052/
    // initiallayoutattributesforappearingitematindexpath-fired-for-all-visible-cells
    // https://markpospesel.wordpress.com/2012/10/25/fixing-circlelayout/

    guard let superAttributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {
      return nil
    }

    // Change the frame of the deleted row

    if self.deleteIndexPaths.contains(itemIndexPath) {

      guard let attributesArray = self.layoutAttributesForElements(in: superAttributes.frame) else {
        return superAttributes
      }

      if attributesArray.count > 0 {

        guard let layoutAttributes = attributesArray.first else {
          return superAttributes
        }

        var frame = layoutAttributes.frame
        frame.origin.x -= frame.size.width
        layoutAttributes.frame = frame

        return layoutAttributes

      } else {
        return superAttributes
      }
    }

    return superAttributes
  }

  override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {

    for item in updateItems {

      if item.updateAction == .delete {
        deleteIndexPaths.append(item.indexPathBeforeUpdate!)
      }
    }
  }

  override func finalizeCollectionViewUpdates() {
    super.finalizeCollectionViewUpdates()

    deleteIndexPaths = [IndexPath]()
  }
}
