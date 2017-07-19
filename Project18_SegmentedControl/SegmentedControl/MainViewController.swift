//
//  MainViewController.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

//  MARK : - MainViewController: UIViewController

class MainViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!

  var page = 1
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationBarColor()
    getDiscoverMovieList()
    
    
  }
  
  func getDiscoverMovieList() {
    
    RestClient.sharedInstance.requestDiscoverMovieList(page: page) { (result, error) in
      
    }
    
    
    
  }
  
  func setNavigationBarColor() {
    navigationController?.navigationBar.barTintColor = UIColor.black
  }
  
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

