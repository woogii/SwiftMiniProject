//
//  CarouselItem.swift
//  Carousel
//
//  Created by siwook on 2017. 5. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation


// MARK : - CarouselItem

struct CarouselItem {

  // MARK : - Property 
  
  var imageName:String
  var title:String
  
  // MARK : - Initialization
  
  init?(dictionary:[String:Any]) {
  
    guard let imageName = dictionary[Constants.JSONKeys.Image] as? String, let title = dictionary[Constants.JSONKeys.Title] as? String else {
      return nil
    }
    
    self.imageName = imageName
    self.title = title
  }
  
  // MARK : - Fetch JSON Data
  
  static func getCarouselItemListFromBundle() -> [CarouselItem]? {
    
    guard let url = Bundle.main.url(forResource: Constants.ResourceName, withExtension: Constants.ResourceExtension) else {
      return nil
    }
    
    do {
      
      let jsonData = try Data(contentsOf: url)
      
      if let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String:Any] {

        if let dictionaryArray = json[Constants.JSONKeys.Items] as? [[String:Any]] {
          
          let carouselItemList = dictionaryArray.flatMap({ dict in
            return CarouselItem.init(dictionary: dict)
          })
          
          return carouselItemList
        }
      }
      
    } catch let error {
      fatalError(error.localizedDescription)
    }
    
    return nil
  }
  
}
