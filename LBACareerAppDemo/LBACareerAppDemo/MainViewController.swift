//
//  ViewController.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 7. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - MainViewController: UICollectionViewController

class MainViewController: UICollectionViewController {

  // MARK : - Property
  
  fileprivate var descriptionItemList = [DescriptionItem]()
  fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 15.0, bottom: 0.0, right: 15.0)
  fileprivate let cellCornerRadius:CGFloat = 4
  fileprivate let cellHeight:CGFloat = 140
  fileprivate let itemSpacing:CGFloat = 10
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchItemList()
  }
  
  func fetchItemList() {
    descriptionItemList = DescriptionItem.getListOfDescriptionItems()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return descriptionItemList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "descriptionCollectionViewCell", for: indexPath) as! DescriptionCollectionViewCell
    cell.layer.cornerRadius = cellCornerRadius
    cell.layer.masksToBounds = true
    
    cell.descriptionItem = descriptionItemList[indexPath.row]
 
    return cell
  }
}

// MARK : - MainViewController: UICollectionViewDelegateFlowLayout

extension MainViewController : UICollectionViewDelegateFlowLayout {
  
  // MARK : - UICollectionViewDelegateFlowLayout Methods 
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let cellWidth = view.frame.size.width - (sectionInsets.left + sectionInsets.right)
    return CGSize(width: cellWidth , height: cellHeight)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return itemSpacing
  }
}
