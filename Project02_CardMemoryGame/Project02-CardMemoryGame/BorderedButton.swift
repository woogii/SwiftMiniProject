//
//  BorderedButton.swift
//  Colour Memory

//  Created by Jarrod Parkes on 1/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.

import Foundation
import UIKit

/* As written above, this code is not my work  */

// MARK: - BorderedButton: Button

class BorderedButton: UIButton {
    
    // MARK: Property
    
    let darkerBlue = UIColor(red: 0.0, green: 0.298, blue: 0.686, alpha:1.0)
    let lighterBlue = UIColor(red: 0.0, green:0.502, blue:0.839, alpha: 1.0)
    let titleLabelFontSize: CGFloat = 12.0
    let borderedButtonWidth: CGFloat = 85.0
    let borderedButtonHeight: CGFloat = 30.0
    let borderedButtonCornerRadius: CGFloat = 4.0
    let phoneBorderedButtonExtraPadding: CGFloat = 14.0
    var backingColor: UIColor? = nil
    var highlightedBackingColor: UIColor? = nil
    
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        themeBorderedButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeBorderedButton()
    }
    
    fileprivate func themeBorderedButton() {
        
        layer.masksToBounds = true
        layer.cornerRadius = borderedButtonCornerRadius
        highlightedBackingColor = darkerBlue
        backingColor = lighterBlue
        backgroundColor = lighterBlue
        setTitleColor(UIColor.white, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: titleLabelFontSize)
    }
    
    // MARK: Setters
    
    fileprivate func setBackingColor(_ newBackingColor: UIColor) {
        
        if let _ = backingColor {
            backingColor = newBackingColor
            backgroundColor = newBackingColor
        }
    }
    
    fileprivate func setHighlightedBackingColor(_ newHighlightedBackingColor: UIColor) {
        
        highlightedBackingColor = newHighlightedBackingColor
        backingColor = highlightedBackingColor
        
    }
    
    // MARK: Tracking
    
    override func beginTracking(_ touch: UITouch, with withEvent: UIEvent?) -> Bool {
        backgroundColor = highlightedBackingColor
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        backgroundColor = backingColor
    }
    
    override func cancelTracking(with event: UIEvent?) {
        backgroundColor = backingColor
    }
    
    // MARK: Layout
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        var sizeThatFits = CGSize.zero
        sizeThatFits.width = borderedButtonWidth
        sizeThatFits.height = borderedButtonHeight
        return sizeThatFits
    }
}
