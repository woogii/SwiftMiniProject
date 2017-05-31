//
//  ViewController.swift
//  Carousel
//
//  Created by siwook on 2017. 5. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CarouselViewController: UICollectionViewController

class CarouselViewController: UICollectionViewController {

  fileprivate var carouselItemList: [CarouselItem]?
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let itemList = CarouselItem.getCarouselItemListFromBundle() {
      carouselItemList = itemList
      print(carouselItemList)
    }

  }

  

}



