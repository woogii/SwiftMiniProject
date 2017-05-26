//
//  DiscardableImageContent.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - DiscardableImageContent : NSObject, NSDiscardableContent

open class DiscardableImageContent : NSObject, NSDiscardableContent {
  
  // MARK : - Property
  
  private(set) public var image : UIImage?
  var  accessedCounter : UInt = 0
  
  // MARK : - Initialization
  
  public init(image:UIImage) {
    self.image = image
  }

 
  // MARK : - Accessing Content
  
  public func beginContentAccess() -> Bool {
    if image == nil {
      return false
    }
    
    accessedCounter += 1
    return true
  }
  
  public func endContentAccess() {
    if accessedCounter > 0 {
      accessedCounter -= 1
    }
  }

  // MARK : - Discarding Content
  
  public func discardContentIfPossible() {
    if accessedCounter == 0 {
      image = nil
    }
    
  }
  
  public func isContentDiscarded() -> Bool {
    if image == nil {
      return true
    } else {
      return false
    }
    
  }
  

}
