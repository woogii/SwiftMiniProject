//
//  ImageCache.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit


// MARK: - MindValleyCache

class CustomCache : NSObject {
  
  // MARK: - Property
  
  private var inMemoryImageCache = NSCache<NSString, DiscardableImageContent>()
  private var inMemoryDataCache = NSCache<NSString, DiscardableDataContent>()
  
  override init() {
    super.init()
    setCacheCapacity()
    
  }
  
  func setCacheCapacity() {
    inMemoryImageCache.countLimit = Constants.MindValleyCache.MaximumCapacity
    inMemoryDataCache.countLimit = Constants.MindValleyCache.MaximumCapacity
  }
  
  // MARK: - Retrieving Images
  
  func retrieveImage(path: String?) -> UIImage? {
  
    if path == nil || path! == "" {
      return nil
    }
    
    if let cachedObject = inMemoryImageCache.object(forKey: path! as NSString) {
      return cachedObject.image
    }
    
    return nil
  }
  
  // MARK: - Saving Images
  
  func storeImage(image: UIImage?, path: String) {
    
    if image == nil {
      inMemoryImageCache.removeObject(forKey: path as NSString)
      return
    }
    
    let data = DiscardableImageContent(image: image!)
    inMemoryImageCache.setObject(data, forKey: path as NSString)
    
  }
  
  // MARK: - Retrieving General Data ( JSON, XML, Etc )
  
  func retrieveData(path: String?) -> Data? {
    
    if path == nil || path! == "" {
      return nil
    }
    
    if let cachedObject = inMemoryDataCache.object(forKey: path! as NSString) {
      return cachedObject.data
    }
    
    return nil
  }
  
  // MARK: - Saving General Data ( JSON, XML, Etc )
  
  func storeData(data: Data?, path: String) {
    
    if data == nil {
      inMemoryDataCache.removeObject(forKey: path as NSString)
      return
    }
    
    let data = DiscardableDataContent(data: data!)
    inMemoryDataCache.setObject(data, forKey: path as NSString)
    
  }

}
