//
//  DiscardableDataContent.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 19..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation


// MARK : - DiscardableDataContent : NSObject, NSDiscardableContent

open class DiscardableDataContent : NSObject, NSDiscardableContent {
  
  // MARK : - Property
  
  private(set) public var data : Data?
  var  accessedCounter : UInt = 0
  
  // MARK : - Initialization
  
  public init(data:Data) {
    self.data = data
  }
  
  
  // MARK : - Accessing Content
  
  public func beginContentAccess() -> Bool {
    if data == nil {
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
      data = nil
    }
    
  }
  
  public func isContentDiscarded() -> Bool {
    if data == nil {
      return true
    } else {
      return false
    }
    
  }
  
  
}
