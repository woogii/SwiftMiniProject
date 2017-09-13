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
  private var gradientLayer: CAGradientLayer?
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

  private func setGradientLayerForCollectionViewBg() {

    if self.gradientLayer == nil {

      self.gradientLayer = CAGradientLayer()
      self.gradientLayer!.colors = [Constant.Colors.Skyblue.cgColor, Constant.Colors.Skyblue.cgColor,
                                    Constant.Colors.LightMagneta.cgColor]
      self.gradientLayer!.locations = [0.0, 0.3, 1.0]
      self.gradientLayer!.frame = self.view.bounds
      self.gradientLayer!.masksToBounds = true
      collectionView?.backgroundView = UIView()
      collectionView?.backgroundView?.layer.insertSublayer(self.gradientLayer!, at: 0)

    }
  }

  // MARK : - Fetch Item List

  private func fetchItemList() {
    descriptionItemList = DescriptionItem.getListOfDescriptionItems()
  }

  // MARK : - UICollectionView DataSource Methods

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return descriptionItemList.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIDs.DescCollectionViewCell,
                                for: indexPath) as? DescriptionCollectionViewCell else {
      return UICollectionViewCell()
    }

    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {

    switch kind {

    case UICollectionElementKindSectionHeader :
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                         withReuseIdentifier:Constant.CellIDs.DescCollectionViewHeader,
                                            for: indexPath) as? DescriptionHeaderView else {
        return UICollectionReusableView()
      }

      headerView.refreshButton.addTarget(self, action: #selector(self.tappedRefreshButton), for: .touchUpInside)
      return headerView
    default:
      assert(false, Constant.CustomErrorMsg.UnexpectedHeaderTypeError)
    }
  }

  // MARK : - Configure Cell

  private func configureCell(cell: DescriptionCollectionViewCell, indexPath: IndexPath) {
    cell.layer.cornerRadius = Constant.MainVC.CollectionViewCellConf.CellCornerRadius
    cell.layer.masksToBounds = true
    cell.dismissAndRemoveButton.tag = indexPath.row
    cell.descriptionItem = descriptionItemList[indexPath.row]
  }

  // MARK : - UICollectionView Delegate Method

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    guard let cell = collectionView.cellForItem(at: indexPath) as? DescriptionCollectionViewCell else {
      return
    }

    if cell.frame.size.height == Constant.MainVC.CollectionViewCellConf.CellHeight {
      showCellDetailWithAnimation(collectionView, cell: cell, indexPath: indexPath)
    }
  }

  // MARK : - Show Cell Detail

  private func showCellDetailWithAnimation(_ collectionView: UICollectionView,
                                           cell: DescriptionCollectionViewCell, indexPath: IndexPath) {

    showOpaqueViewBackground(collectionView)
    showCellInTopLayer(cell: cell)

    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {

      self.configureCellWhenExpanding(collectionView, cell: cell)
      collectionView.setContentOffset(CGPoint(x:0, y:0), animated: true)
      collectionView.isScrollEnabled = false
    }, completion: { _ in

    })

  }

  // MARK : - Target Action Methods

  func tappedDismissButton(_ sender:Any) {

    guard let button = sender as? UIButton,
          let cell = button.superview?.superview as? DescriptionCollectionViewCell else {
      return
    }

    collectionView?.isScrollEnabled = true
    opaqueView.removeFromSuperview()

    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {

      self.configureCellWhenCollapsing(cell: cell)

    }, completion : { _ in
      self.collectionView?.sendSubview(toBack: cell)
    })

  }

  func tappedDismissAndRemoveButton(_ sender:Any) {

    guard let button = sender as? UIButton,
          let cell = button.superview?.superview as? DescriptionCollectionViewCell else {
      return
    }
    let rowIndex = button.tag

    collectionView?.isScrollEnabled = true
    opaqueView.removeFromSuperview()

    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {

      self.configureCellWhenCollapsing(cell: cell)

    }, completion : { _ in
      self.collectionView?.sendSubview(toBack: cell)
      self.remove(rowIndex)
    })
  }

  func tappedRefreshButton() {
    collectionView?.reloadData()
  }

  private func configureCellWhenExpanding(_ collectionView: UICollectionView, cell: DescriptionCollectionViewCell) {
    backUpCellFrame(cell)
    changeCellFrame(cell, frame: collectionView.frame)
    displaySubviews(cell, hiddenStatus: false)
    adjustDescriptionLabelLines(cell, numberOfLines: Constant.MainVC.DefaultDescriptionLabelLine)
    addButtonActions(cell)
  }

  private func addButtonActions(_ cell: DescriptionCollectionViewCell) {

    cell.dismissButton.addTarget(self, action: #selector(self.tappedDismissButton(_:)), for: .touchUpInside)
    cell.dismissAndRemoveButton.addTarget(self,
                                          action: #selector(self.tappedDismissAndRemoveButton(_:)),
                                          for: .touchUpInside)
  }

  private func configureCellWhenCollapsing(cell: DescriptionCollectionViewCell) {

    restoreCellFrame(cell)
    adjustDescriptionLabelLines(cell, numberOfLines: Constant.MainVC.AbbreviatedDescriptionLabelLine)
    displaySubviews(cell, hiddenStatus: true)
  }

  private func displaySubviews(_ cell: DescriptionCollectionViewCell, hiddenStatus: Bool) {
    cell.middleSeparatorImageView.isHidden = hiddenStatus
    cell.lowerSeparatorImageView.isHidden = hiddenStatus
    cell.dismissButton.isHidden = hiddenStatus
    cell.dismissAndRemoveButton.isHidden = hiddenStatus
  }

  private func backUpCellFrame(_ cell: DescriptionCollectionViewCell) {
    #if DEBUG
      print("backup : \(cell.frame)")
    #endif
    self.originalCellFrame = cell.frame
  }

  private func changeCellFrame(_ cell: DescriptionCollectionViewCell, frame: CGRect) {
    cell.frame = CGRect(x: Constant.MainVC.CollectionViewConf.SectionInsets.left,
                        y: Constant.MainVC.CollectionViewCellConf.EnlargedCellTopMargin,
                        width: frame.size.width - Constant.MainVC.CollectionViewConf.SectionInsets.left*2,
                        height: frame.size.height - Constant.MainVC.CollectionViewCellConf.EnlargedCellHeightMargin)
  }

  private func restoreCellFrame(_ cell: DescriptionCollectionViewCell) {
    #if DEBUG
      print("restore : \(self.originalCellFrame)")
    #endif
    cell.frame = self.originalCellFrame
  }

  private func adjustDescriptionLabelLines(_ cell: DescriptionCollectionViewCell, numberOfLines: Int) {
    cell.descriptionLabel.numberOfLines = numberOfLines
  }

  // MARK : - Remove Single Row

  private func remove(_ index: Int) {

    descriptionItemList.remove(at: index)

    let indexPath = IndexPath(row: index, section: 0)

    self.collectionView?.performBatchUpdates({
      self.collectionView?.deleteItems(at: [indexPath])
    }) { (_) in

      guard let visibleItems = self.collectionView?.indexPathsForVisibleItems else {
        return
      }
      self.collectionView?.reloadItems(at: visibleItems)
    }
  }

  private func showOpaqueViewBackground(_ collectionView: UICollectionView) {
    opaqueView.frame = view.frame
    collectionView.addSubview(opaqueView)
  }

  private func showCellInTopLayer(cell: DescriptionCollectionViewCell) {
    cell.superview?.bringSubview(toFront: cell)
  }
}

// MARK : - MainViewController: UICollectionViewDelegateFlowLayout

extension MainViewController : UICollectionViewDelegateFlowLayout {

  // MARK : - UICollectionViewDelegateFlowLayout Methods

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let cellWidth = view.frame.size.width -
        (Constant.MainVC.CollectionViewConf.SectionInsets.left + Constant.MainVC.CollectionViewConf.SectionInsets.right)
    return CGSize(width: cellWidth, height: Constant.MainVC.CollectionViewCellConf.CellHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Constant.MainVC.CollectionViewConf.SectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constant.MainVC.CollectionViewConf.ItemSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 140)
  }

}
