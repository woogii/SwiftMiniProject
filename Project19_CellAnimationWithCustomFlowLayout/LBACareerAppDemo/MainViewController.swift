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
  fileprivate let enlargedCellTopMargin:CGFloat = 36
  fileprivate let enlargedCellHeightMargin:CGFloat = 50
  fileprivate let defaultDescriptionLabelLine = 0
  fileprivate let abbreviatedDescriptionLabelLine = 5
  
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
    cell.dismissAndRemoveButton.tag = indexPath.row
    cell.descriptionItem = descriptionItemList[indexPath.row]
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    switch kind {
      
    case UICollectionElementKindSectionHeader :
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! DescriptionHeaderView
      
      headerView.refreshButton.addTarget(self, action: #selector(self.tappedRefreshButton), for: .touchUpInside)
      return headerView
    default:
      assert(false, UnexpectedHeaderTypeError)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) as? DescriptionCollectionViewCell else {
      return
    }
    
    if cell.frame.size.height == cellHeight {
      showCellDetailWithAnimation(collectionView, cell: cell, indexPath: indexPath)
    }
    
  }
  
  // MARK : - Show Cell Detail
  
  private func showCellDetailWithAnimation(_ collectionView:UICollectionView, cell:DescriptionCollectionViewCell, indexPath:IndexPath) {
    
    showOpaqueViewBackground(collectionView)
    showCellInTopLayer(cell: cell)
  
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      
      self.configureCellWhenExpanding(collectionView,cell: cell)
      collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
      collectionView.isScrollEnabled = false
    }, completion: { finished in
      
    })
    
  }
  
  // MARK : - Target Action Methods
  
  func tappedDismissButton(_ sender:Any) {
    
    let button = sender as? UIButton
    guard let cell = button?.superview?.superview as? DescriptionCollectionViewCell else {
      return
    }
    
    collectionView?.isScrollEnabled = true
    opaqueView.removeFromSuperview()

    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      
      self.configureCellWhenCollapsing(cell: cell)
    
    }, completion : { finished in
      self.collectionView?.sendSubview(toBack: cell)
    })
    
  }
  
  func tappedDismissAndRemoveButton(_ sender:Any) {
    
    let button = sender as? UIButton
    guard let cell = button?.superview?.superview as? DescriptionCollectionViewCell else {
      return
    }
    let rowIndex = button?.tag
    
    collectionView?.isScrollEnabled = true
    opaqueView.removeFromSuperview()
    
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      
      self.configureCellWhenCollapsing(cell: cell)
      
    }, completion : { finished in
      self.collectionView?.sendSubview(toBack: cell)
      self.remove(rowIndex!)
    })
  }
  
  
  func tappedRefreshButton() {
    collectionView?.reloadData()
  }
  
  func configureCellWhenExpanding(_ collectionView:UICollectionView, cell:DescriptionCollectionViewCell) {
    
    
    backUpCellFrame(cell)
    changeCellFrame(cell, frame: collectionView.frame)
    displaySubviews(cell, hiddenStatus: false)
    adjustDescriptionLabelLines(cell, numberOfLines: defaultDescriptionLabelLine)
    addButtonActions(cell)
    
  }
  
  func addButtonActions(_ cell:DescriptionCollectionViewCell) {
    
    cell.dismissButton.addTarget(self, action: #selector(self.tappedDismissButton(_:)), for: .touchUpInside)
    cell.dismissAndRemoveButton.addTarget(self, action: #selector(self.tappedDismissAndRemoveButton(_:)), for: .touchUpInside)
  }
  
  func configureCellWhenCollapsing(cell:DescriptionCollectionViewCell) {
    
    restoreCellFrame(cell)
    adjustDescriptionLabelLines(cell, numberOfLines: abbreviatedDescriptionLabelLine)
    displaySubviews(cell, hiddenStatus: true)
  }
  
  func displaySubviews(_ cell: DescriptionCollectionViewCell, hiddenStatus:Bool) {
    cell.middleSeparatorImageView.isHidden = hiddenStatus
    cell.lowerSeparatorImageView.isHidden = hiddenStatus
    cell.dismissButton.isHidden = hiddenStatus
    cell.dismissAndRemoveButton.isHidden = hiddenStatus
  }
  
  func backUpCellFrame(_ cell: DescriptionCollectionViewCell) {
    print("backup : \(cell.frame)")
    self.originalCellFrame = cell.frame
  }
  
  func changeCellFrame(_ cell: DescriptionCollectionViewCell, frame:CGRect) {
    cell.frame = CGRect(x: self.sectionInsets.left, y: self.enlargedCellTopMargin, width: frame.size.width - self.sectionInsets.left*2, height: frame.size.height - self.enlargedCellHeightMargin)

  }
  
  func restoreCellFrame(_ cell: DescriptionCollectionViewCell) {
    print("restore : \(self.originalCellFrame)")
    cell.frame = self.originalCellFrame
  }
  
  func adjustDescriptionLabelLines(_ cell: DescriptionCollectionViewCell,numberOfLines:Int) {
    cell.descriptionLabel.numberOfLines = numberOfLines
  }
  
  // MARK : - Remove Single Row
  
  func remove(_ i: Int) {
    
    descriptionItemList.remove(at: i)
    
    let indexPath = IndexPath(row: i, section: 0)
    
    self.collectionView?.performBatchUpdates({
      self.collectionView?.deleteItems(at: [indexPath])
    }) { (finished) in
      
      guard let visibleItems = self.collectionView?.indexPathsForVisibleItems else {
        return
      }
      self.collectionView?.reloadItems(at: visibleItems)
    }
    
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
