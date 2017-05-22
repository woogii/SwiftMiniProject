//
//  ViewController.swift
//  Project01-BarGraphInCollectionView
//
//  Created by TeamSlogup on 2016. 9. 25..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController

class ViewController: UIViewController {

  // MARK : - Property
  
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var collectionView: UICollectionView!
  let cellIdentifier = "barGraphCollectionViewCell"
  let figureSuffix = "%"
  let numberOfData = 5
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurePageControl()
    
    if #available(iOS 10.0, *) {
      collectionView.isPrefetchingEnabled = false
    } else {
      // Fallback on earlier versions
    }
    
  }

  func configurePageControl() {
    pageControl.backgroundColor = UIColor.clear
    pageControl.pageIndicatorTintColor = UIColor.lightGray
    pageControl.currentPageIndicatorTintColor = UIColor.blue
    pageControl.numberOfPages = numberOfData
  }
  
}

// MARK : - ViewController: UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
  
  // MARK : - Collection view data source
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return numberOfData
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BarGraphCollectionViewCell
    cell.configureCell(indexPath: indexPath)
    return cell
  }

}

// MARK : - ViewController: UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
  
}

// MARK : - ViewController: UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    let pageWidth = collectionView.frame.size.width
    pageControl.currentPage  = Int(floor((collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
  }
  
}
