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
  fileprivate let collectionViewInsets = UIEdgeInsets(top: 100.0, left: 20.0, bottom: 100.0, right: 20.0)
  private var cellIdentifier = "cell"
  @IBOutlet weak var vcBackgroundImageView: UIImageView!
  
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCarouselItemList()
    addBlurView()
  
  }
  
  func addBlurView() {
  
    let blurEffect = UIBlurEffect(style: .extraLight)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = vcBackgroundImageView.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    vcBackgroundImageView.addSubview(blurEffectView)
    
  }
  
  func fetchCarouselItemList() {
    
    if let itemList = CarouselItem.getCarouselItemListFromBundle() {
      carouselItemList = itemList
      print(carouselItemList as Any)
    }
    
  }
  
  // MARK : - UICollectionView DataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    guard let list = carouselItemList else {
      return 0
    }
    
    return list.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let itemList = carouselItemList else {
      return UICollectionViewCell()
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CarouselCollectionViewCell
    cell.carouselItem = itemList[indexPath.item]
    
    return cell
  }
}


// MARK : - CarouselViewController : UICollectionViewDelegateFlowLayout
  
extension CarouselViewController : UICollectionViewDelegateFlowLayout {
  
  // MARK : - UICollectionViewDelegateFlowLayout Methods 
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let padding = collectionViewInsets.left
    let width = view.frame.width - (padding * 2)
    let height = view.frame.height - (collectionViewInsets.bottom*2)
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return collectionViewInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return collectionViewInsets.left
  }
}

