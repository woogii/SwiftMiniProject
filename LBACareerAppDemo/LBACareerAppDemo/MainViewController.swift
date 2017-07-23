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
  private var magneta = UIColor(red: 147.0/255.0, green: 112.0/255.0, blue: 219.0/255.0, alpha: 0.6)
  fileprivate let opaqueView: UIView = {
    let opaqueView = UIView()
    opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return opaqueView
  }()
  
  var originalCellFrame = CGRect()
  
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
    
    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }
  
  // MARK : - Configure Cell 
  
  private func configureCell(cell:DescriptionCollectionViewCell, indexPath:IndexPath) {
    
    cell.layer.cornerRadius = cellCornerRadius
    cell.layer.masksToBounds = true
    cell.descriptionItem = descriptionItemList[indexPath.row]
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
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) as? DescriptionCollectionViewCell else {
      return
    }
    
    showCellDetailWithAnimation(collectionView, cell: cell, indexPath: indexPath)
   
    
  }
  
  // MARK : - Show Cell Detail
  
  private func showCellDetailWithAnimation(_ collectionView:UICollectionView, cell:DescriptionCollectionViewCell, indexPath:IndexPath) {
    
    showOpaqueViewBackground(collectionView)
    showCellInTopLayer(cell: cell)
    
    collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
    
      self.originalCellFrame = cell.frame
      print("original frame : \(self.originalCellFrame)")
      print("collectionView frame : \(self.collectionView!.frame)")
      
      cell.frame = CGRect(x: 15.0, y: 36.0, width: collectionView.frame.size.width-30.0, height: collectionView.frame.size.height - 50.0)
    
      collectionView.isScrollEnabled = false
      cell.middleSeparatorImageView.isHidden = false
      cell.lowerSeparatorImageView.isHidden = false
      cell.dismissButton.isHidden = false
      cell.descriptionLabel.numberOfLines = 0
      cell.dismissAndRemoveButton.isHidden = false
      
      cell.dismissButton.addTarget(self, action: #selector(self.tappedDismissButton(_:)), for: .touchUpInside)
    }, completion: nil)

  }
  
  func tappedDismissButton(_ sender:Any) {
  
    let button = sender as? UIButton
    let cell = button?.superview?.superview as? DescriptionCollectionViewCell
    collectionView?.isScrollEnabled = true
    opaqueView.removeFromSuperview()
    
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
    cell?.frame = self.originalCellFrame
    
    cell?.middleSeparatorImageView.isHidden = true
    cell?.lowerSeparatorImageView.isHidden = true
    cell?.dismissButton.isHidden = true
    cell?.descriptionLabel.numberOfLines = 5
    cell?.dismissAndRemoveButton.isHidden = true
    
    
    }, completion : { finished in 
      self.collectionView?.sendSubview(toBack: cell!)
    })
    
  }

  func showOpaqueViewBackground(_ collectionView:UICollectionView) {
    opaqueView.frame = view.frame
    collectionView.addSubview(opaqueView)
  }
  
  func showCellInTopLayer(cell:DescriptionCollectionViewCell) {
    cell.superview?.bringSubview(toFront: cell)
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


// MARK : - UIImage Extension

extension UIImage {
  
  static func drawDottedImage(width: CGFloat, height: CGFloat, color: UIColor) -> UIImage {
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 1.0, y: 1.0))
    path.addLine(to: CGPoint(x: width, y: 1))
    path.lineWidth = 1.5
    let dashes: [CGFloat] = [path.lineWidth, path.lineWidth * 5]
    path.setLineDash(dashes, count: Int(1.5), phase: 0)
    path.lineCapStyle = .butt
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 2)
    color.setStroke()
    path.stroke()
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return image
  }
}
