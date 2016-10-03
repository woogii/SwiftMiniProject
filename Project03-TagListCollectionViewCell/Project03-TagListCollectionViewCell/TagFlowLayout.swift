//
//  TagFlowLayout.swift
//  Project03-TagListCollectionViewCell
//
//  Created by TeamSlogup on 2016. 10. 3..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - TagFlowLayout: UICollectionViewFlowLayout 

class TagFlowLayout: UICollectionViewFlowLayout {

    // MARK : - Configure layout attribute
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        
        // use a value to keep track of left margin
        var leftMargin: CGFloat = 0.0
        
        for attributes in attributesForElementsInRect! {
            
            let refAttributes = attributes
            
            if (refAttributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            leftMargin += refAttributes.frame.size.width
            newAttributesForElementsInRect.append(refAttributes)
        }
        
        return newAttributesForElementsInRect
    }

}
