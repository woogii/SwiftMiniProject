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

  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.barTintColor = UIColor.black
    
    RestClient.sharedInstance.requestDiscoverMovieList { (result, error) in
      print(result)
    }
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

