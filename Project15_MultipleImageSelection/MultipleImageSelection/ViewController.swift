//
//  ViewController.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import DKImagePickerController

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var bioTextView: UITextView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var upperView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var addProfileButton: UIButton!
  
  let menuTitle = ["Location","Website","Birthday"]
  let menuDescription = ["Seoul, Korea","http://woogii.devport.co/","2016-09-25"]
  let cellIdentifier = "cell"
  let profileImageCellID = "profileImageCell"
  lazy var selectedImages : [UIImage] = {
    let selectedImages = [UIImage]()
    return selectedImages
  }()
  
  lazy var pickerController : DKImagePickerController = {
    let pickerController = DKImagePickerController()
    pickerController.maxSelectableCount = 5
    pickerController.showsCancelButton = true
    pickerController.defaultSelectedAssets = nil
    return pickerController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTextViewInset()
    setPageControlProperties()
  }
  
  func setPageControlProperties() {
    pageControl.numberOfPages = selectedImages.count
    pageControl.pageIndicatorTintColor = UIColor.lightGray
    pageControl.currentPageIndicatorTintColor = UIColor.white
    pageControl.hidesForSinglePage = true
  }
  
  func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
  
  func setTextViewInset() {
    bioTextView.textContainerInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 0.0, right: 0.0)
    
  }
  
  @IBAction func tappedAddProfileButton(_ sender: UIButton) {
    
    let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default, handler: { action in
      self.showImagePicker()
    })
    
    actionsheet.addAction(photoLibraryAction)
    
    let takePhotoAction = UIAlertAction(title: "Take Profile Photo", style: .default, handler: nil)
    actionsheet.addAction(takePhotoAction)
    
    let cancelAction = UIAlertAction(title:"Cancel", style:.cancel, handler:nil)
    actionsheet.addAction(cancelAction)
    
    present(actionsheet, animated: true, completion: nil)
    
  }
  
  func showImagePicker() {
    
    let workGroup = DispatchGroup()
    
    pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
      
      if assets.count > 0 {
        
        workGroup.enter()
        
        for asset in assets {
          
          asset.fetchOriginalImage(true, completeBlock: { image, info in
            
            //let fileName = self.fetchImageName(fileInfo: info)
            //self.imageFileNames.append(fileName)
            self.selectedImages.append(image!)
            
          })
        }
        
        workGroup.leave()
        
        workGroup.notify(queue: DispatchQueue.main) {
          
          DispatchQueue.main.async {
            //self.displayPictureAddViewBasedOn(hiddenStatus: true)
            //self.displayDeleteAllImagesButtonBasedOn(hiddenStatus: false)
            //self.setImageCountLabel(numberOfImage: self.selectedImages.count)
            self.addProfileButton.isHidden = true
            self.upperView.isHidden = true
            self.pageControl.numberOfPages = self.selectedImages.count
            self.collectionView?.reloadData()
          }
          
        }
        
      }
    }
    
    pickerController.didCancel = {
      
    }
    
    self.present(pickerController, animated: true) {}
  }
  
  
  
}


extension ViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuTitle.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileInfoCell
    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }
  
  func configureCell(cell:ProfileInfoCell, indexPath:IndexPath) {
    cell.titleLabel.text = menuTitle[indexPath.row]
    cell.descriptionLabel.text = menuDescription[indexPath.row]
  }
}

extension ViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.selectedImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileImageCellID, for: indexPath) as! ProfileImageCollectionViewCell
    cell.profileImageView.image = selectedImages[indexPath.row].resizeImage()
  
    return cell
  }
}

extension ViewController : UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    let pageWidth = collectionView.frame.size.width
    pageControl.currentPage = Int(floor((collectionView.contentOffset.x-pageWidth/2)/pageWidth)+1)

  }
}

extension UIImage {
  
  func resizeImage()-> UIImage {
    
    if size.width < UIScreen.main.bounds.width {
      
      let scaleToWidth = UIScreen.main.bounds.width
      let oldWidth = size.width
      let scaleFactor = scaleToWidth / oldWidth
      
      let newHeight = size.height * scaleFactor
      let newWidth = oldWidth * scaleFactor
      
      UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
      draw(at: .zero)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return newImage!
    } else {
      return self
    }
  }
  
}
