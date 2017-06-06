//
//  ImageEditTypeLauncher.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 4..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit


// MARK : - ImageEditTypeLauncherDelegate (Protocol)
  
protocol ImageEditTypeLauncherDelegate {
  
  func performImageEditing(editTypIndex :ImageEditType, imageIndex:Int)
}

// MARK : - ImageEditType (Enum)

enum ImageEditType {
  case modify
  case delete
}

// MARK : - ImageEditTypeLauncher : NSObject

class ImageEditTypeLauncher : NSObject {

  // MARK : - Property
  
  let blackView = UIView()
  let cellID = "imageEditTypeLauncherCell"
  let cellHeight:CGFloat = 60
  let imageEditType = ["Modify Image","Delete Image"]
  let collectionView :  UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.white
    return collectionView
  }()
  var delegate : ImageEditTypeLauncherDelegate?
  var imageIndex:Int!
  
  // MARK : - Initialization
  
  override init() {
    
    super.init()
    configureCollectionView()
  }
  
  func configureCollectionView() {
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(ImageEditTypeCell.self, forCellWithReuseIdentifier: cellID)
  }
  
  func showEditType(imageIndex: Int) {
    
    self.imageIndex = imageIndex
    
    if let window:UIWindow = UIApplication.shared.keyWindow {
      
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height:CGFloat = CGFloat(imageEditType.count) * cellHeight
      let yCoordinate = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
        self.blackView.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: yCoordinate, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
      }, completion: nil)

      
    }
  }
  
  func handleDismiss() {
    
    UIView.animate(withDuration: 0.3, animations: {
      
      self.blackView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow {
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
      }
    })
  }

  
  
  
}

extension ImageEditTypeLauncher : UICollectionViewDataSource, UICollectionViewDelegate {

  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageEditType.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageEditTypeCell
    
    cell.editTypeLabel.text = imageEditType[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    var editType:ImageEditType!
    
    indexPath.item == 0 ? (editType = ImageEditType.modify) : (editType = ImageEditType.delete)
    delegate?.performImageEditing(editTypIndex: editType, imageIndex: imageIndex)
    handleDismiss()
  }
  
  
}

extension ImageEditTypeLauncher : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}





extension UIView {
  
  func addConstraintsWithFormat(format: String, views: UIView...) {
    
    var viewDictionary = [String: UIView]()
    
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                       options: NSLayoutFormatOptions(),
                                                       metrics: nil,
                                                       views: viewDictionary))
  }

}
