//
//  ImageEditTypeLauncher.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 4..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

class ImageEditTypeLauncher : NSObject {
  
  
  var collectionView : UICollectionView!
  
  override init() {
    
    super.init()
    
    configureCollectionView()
  }
  
  func configureCollectionView() {
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
  }
  
  func showEditType() {
    
    
  }
  
  
}

extension ImageEditTypeLauncher : UICollectionViewDataSource, UICollectionViewDelegate {

  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
  

}


