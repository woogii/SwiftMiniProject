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
  private var skyblue = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 235.0/255.0, alpha: 1.0)
  private var lightMagneta = UIColor(red: 147.0/255.0, green: 112.0/255.0, blue: 219.0/255.0, alpha: 0.6)
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchItemList()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    setGradientLayerForCollectionViewBg()
  }
  
  // MARK : - Set Gradient Layer
  
  func setGradientLayerForCollectionViewBg() {
    if self.gradientLayer == nil {
      
      self.gradientLayer = CAGradientLayer()
      self.gradientLayer!.colors = [skyblue.cgColor, skyblue.cgColor, lightMagneta.cgColor]
      self.gradientLayer!.locations = [0.0, 0.3, 1.0]
      self.gradientLayer!.frame = self.view.bounds
      self.gradientLayer!.masksToBounds = true
      collectionView?.backgroundView = UIView()
      collectionView?.backgroundView?.layer.insertSublayer(self.gradientLayer!, at: 0)
      
    }
  }
  
  // MARK : - Fetch Item List
  
  func fetchItemList() {
    descriptionItemList = DescriptionItem.getListOfDescriptionItems()
  }
  
  // MARK : - UICollectionView DataSource Methods
  
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
