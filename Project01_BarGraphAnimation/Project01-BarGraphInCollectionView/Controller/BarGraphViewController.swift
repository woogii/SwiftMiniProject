//
//  BarGraphViewController.swift
//  Project01-BarGraphInCollectionView
//
//  Created by TeamSlogup on 2016. 9. 25..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - BarGraphViewController: UIViewController

class BarGraphViewController: UIViewController {
  // MARK : - Property
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var collectionView: UICollectionView!
  fileprivate var ratioValues = [RatioValue]()
  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
    configurePageControl()
    if #available(iOS 10.0, *) {
      collectionView.isPrefetchingEnabled = false
    } else {
      // Fallback on earlier versions
    }
  }
  private func fetchData() {
    ratioValues = RatioValue.getRatioValueList()
  }
  private func configurePageControl() {
    pageControl.backgroundColor = UIColor.clear
    pageControl.pageIndicatorTintColor = UIColor.lightGray
    pageControl.currentPageIndicatorTintColor = UIColor.blue
    pageControl.numberOfPages = ratioValues.count
  }
}

// MARK : - BarGraphViewController: UICollectionViewDataSource
extension BarGraphViewController : UICollectionViewDataSource {
  // MARK : - Collection view data source
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ratioValues.count
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier,
                                                  for: indexPath) as? BarGraphCollectionViewCell else {
                                                    return BarGraphCollectionViewCell()
    }
    cell.ratioValue = ratioValues[indexPath.row]
    return cell
  }
}

// MARK : - BarGraphViewController: UICollectionViewDelegateFlowLayout
extension BarGraphViewController : UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
}

// MARK : - BarGraphViewController: UIScrollViewDelegate

extension BarGraphViewController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = collectionView.frame.size.width
    pageControl.currentPage  = Int(floor((collectionView.contentOffset.x
                                          - pageWidth / 2) / pageWidth) + 1)
  }
}
