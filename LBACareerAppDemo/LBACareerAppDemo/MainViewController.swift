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
  
  // @IBOutlet weak var collectionView: UICollectionView!
  fileprivate var descriptionItemList = [DescriptionItem]()
  fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0)
  fileprivate let cellCornerRadius:CGFloat = 4
  fileprivate let cellHeight:CGFloat = 140
  fileprivate let itemSpacing:CGFloat = 10
  fileprivate let cellIdentifier = "descriptionCollectionViewCell"
  fileprivate let headerIdentifier = "descriptionHeaderView"
  fileprivate let UnexpectedHeaderTypeError = "Unexpected element kind"
  
  private var gradientLayer:CAGradientLayer? = nil
  private var skyblue = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
  private var magneta = UIColor(red: 147.0/255.0, green: 112.0/255.0, blue: 219.0/255.0, alpha: 1.0).cgColor
  
  // 147, 112, 219
  // 135, 206, 235
  
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchItemList()
    fixCollectionViewHeader()
  
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
  
    super.viewWillAppear(animated)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if gradientLayer == nil {
      
      gradientLayer = CAGradientLayer()
      
      gradientLayer!.colors = [skyblue, magneta]
      gradientLayer!.locations = [0.0, 1.0]
      //print(collectionView?.frame)
      //print(collectionView?.bounds)
      gradientLayer!.bounds = (self.collectionView?.bounds)!
      gradientLayer!.masksToBounds = true
      
      collectionView?.backgroundView?.layer.addSublayer(gradientLayer!)
      
      
    }

    
  }
  
  
  func fixCollectionViewHeader() {
    let flowLayout = collectionView?.collectionViewLayout as!  UICollectionViewFlowLayout
    //flowLayout.sectionHeadersPinToVisibleBounds = true
  }
  
  func fetchItemList() {
    descriptionItemList = DescriptionItem.getListOfDescriptionItems()
    
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return descriptionItemList.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DescriptionCollectionViewCell
      cell.layer.cornerRadius = cellCornerRadius
      cell.layer.masksToBounds = true
  
      cell.descriptionItem = descriptionItemList[indexPath.row]
  
      return cell
    }
  
   override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    switch kind {
      
    case UICollectionElementKindSectionHeader :
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! DescriptionHeaderView
      
      return headerView
    default:
      assert(false, UnexpectedHeaderTypeError)
    }
  }
  
}


//extension MainViewController : UICollectionViewDataSource {
//  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return descriptionItemList.count
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "descriptionCollectionViewCell", for: indexPath) as! DescriptionCollectionViewCell
//    cell.layer.cornerRadius = cellCornerRadius
//    cell.layer.masksToBounds = true
//    
//    cell.descriptionItem = descriptionItemList[indexPath.row]
//    
//    return cell
//  }
//  
//}

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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 140)
  }
  
}
