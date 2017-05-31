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
  
  init?(dictionary:[String:Any]) {
  
    guard let imageName = dictionary["image"] as? String, let title = dictionary["title"] as? String else {
      return nil
    }
    
    self.imageName = imageName
    self.title = title
  }
  
  static func getCarouselItemListFromBundle() -> [CarouselItem]? {
    
    guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else {
      return nil
    }
    
    do {
      
      let jsonData = try Data(contentsOf: url)
      
      if let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String:Any] {

        if let dictionaryArray = json["items"] as? [[String:Any]] {
          
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
