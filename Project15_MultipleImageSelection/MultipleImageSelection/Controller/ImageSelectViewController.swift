//
//  ImageSelectViewController.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import DKImagePickerController

// MARK : - ImageSelectViewController: UIViewController
class ImageSelectViewController: UIViewController {
  // MARK : - Property
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var bioTextView: UITextView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var upperView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var addProfileButton: UIButton!
  let menuTitle = ["Location", "Website", "Birthday"]
  let menuDescription = ["Seoul, Korea", "http://woogii.devport.co/", "2016-09-25"]
  lazy var selectedImages: [UIImage] = {
    let selectedImages = [UIImage]()
    return selectedImages
  }()
  lazy var imageEditTypeLauncher: ImageEditTypeLauncher = {
    let launcher = ImageEditTypeLauncher()
    launcher.delegate = self
    return launcher
  }()
  lazy var pickerController: DKImagePickerController = {
    let pickerController = DKImagePickerController()
    pickerController.maxSelectableCount = 5
    pickerController.showsCancelButton = true
    pickerController.defaultSelectedAssets = nil
    return pickerController
  }()
  // MARK : - View Life Cycle
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
  // MARK : - Target Actions
  @IBAction func tappedAddProfileButton(_ sender: UIButton) {
    let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let photoLibraryAction = UIAlertAction(title: Constants.AlertTitle.PhotoLibrary, style: .default, handler: { _ in
      self.showImagePicker()
    })
    actionsheet.addAction(photoLibraryAction)
    let takePhotoAction = UIAlertAction(title: Constants.AlertTitle.TakePhoto, style: .default, handler: nil)
    actionsheet.addAction(takePhotoAction)
    let cancelAction = UIAlertAction(title:Constants.AlertTitle.Cancel, style:.cancel, handler:nil)
    actionsheet.addAction(cancelAction)
    present(actionsheet, animated: true, completion: nil)
  }
  // MARK : - Show Image Picker
  func showImagePicker() {
    let workGroup = DispatchGroup()
    pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
      if assets.count > 0 {
        workGroup.enter()
        for asset in assets {
          asset.fetchOriginalImage(true, completeBlock: { image, _ in
            // Add selected Images to selectedImages array
            self.selectedImages.append(image!)
          })
        }
        workGroup.leave()
        workGroup.notify(queue: DispatchQueue.main) {
          DispatchQueue.main.async {
            self.displayUIBaedOnImageCount(selectedImageCount: self.selectedImages.count)
            self.pageControl.numberOfPages = self.selectedImages.count
            self.collectionView?.reloadData()
          }
        }
      }
    }
    pickerController.didCancel = {}
    self.present(pickerController, animated: true) {}
  }
  func showAlert(message: String) {
    let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: Constants.AlertTitle.Confirm, style: .default, handler: nil)
    alertController.addAction(okAction)
    let cancelAction = UIAlertAction(title: Constants.AlertTitle.Cancel, style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true, completion: nil)

  }
  func setPickerControllerImageConstraint(selectedImageCount: Int) {
    pickerController.maxSelectableCount = Constants.MaxImageCount - selectedImageCount
    pickerController.deselectAllAssets()
  }
  func displayUIBaedOnImageCount(selectedImageCount: Int) {
    if selectedImageCount == 0 {
      self.collectionView.isHidden = true
      self.addProfileButton.isHidden = false
      self.upperView.isHidden = false
    } else {
      self.addProfileButton.isHidden = true
      self.upperView.isHidden = true
      self.collectionView.isHidden = false
    }
  }
}
// MARK : - ImageSelectViewController : ImageEditTypeLauncherDelegate
extension ImageSelectViewController : ImageEditTypeLauncherDelegate {
  func performImageEditing(editTypIndex: ImageEditType, imageIndex: Int) {
    if editTypIndex == ImageEditType.modify {
      if selectedImages.count < Constants.MaxImageCount {
        setPickerControllerImageConstraint(selectedImageCount: selectedImages.count)
        showImagePicker()
      } else {
        showAlert(message: Constants.AlertMessage.MaximumImageCountReached)
      }
    } else {
      selectedImages.remove(at: imageIndex)
      setPickerControllerImageConstraint(selectedImageCount: selectedImages.count)
      displayUIBaedOnImageCount(selectedImageCount: selectedImages.count)
      pageControl.numberOfPages = selectedImages.count
      DispatchQueue.main.async {
          self.collectionView.reloadData()
      }
    }
  }
}
// MARK : - ImageSelectViewController : UITableViewDataSource
extension ImageSelectViewController : UITableViewDataSource {
  // MARK : UITableViewDataSource Method
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuTitle.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
                                                   withIdentifier: Constants.CellID.ProfileInfo,
                                                   for: indexPath) as? ProfileInfoCell else {
      return ProfileInfoCell()
    }
    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }
  func configureCell(cell: ProfileInfoCell, indexPath: IndexPath) {
    cell.titleLabel.text = menuTitle[indexPath.row]
    cell.descriptionLabel.text = menuDescription[indexPath.row]
  }
}
// MARK : - ImageSelectViewController : UICollectionViewDataSource
extension ImageSelectViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.selectedImages.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: Constants.CellID.ProfileImage, for: indexPath) as? ProfileImageCollectionViewCell else {
      return ProfileImageCollectionViewCell()
    }
    configureProfileImageCell(cell: cell, indexPath: indexPath)
    return cell
  }
  func configureProfileImageCell(cell: ProfileImageCollectionViewCell, indexPath: IndexPath) {
    cell.profileImageView.image = selectedImages[indexPath.row].resizeImage()
    cell.profileImageView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(editImage(tapGestureRecognizer:))))
    cell.profileImageView.isUserInteractionEnabled = true
    cell.profileImageView.tag = indexPath.item
  }
  func editImage(tapGestureRecognizer: UITapGestureRecognizer) {
    guard let tappedImageView = tapGestureRecognizer.view as? UIImageView else {
      return
    }
    let index = tappedImageView.tag
    imageEditTypeLauncher.showEditType(imageIndex: index)
  }
}
// MARK : - ImageSelectViewController : UIScrollViewDelegate
extension ImageSelectViewController : UIScrollViewDelegate {
  // MARK : - UIScrollViewDelegate Method
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = collectionView.frame.size.width
    pageControl.currentPage = Int(floor((collectionView.contentOffset.x-pageWidth/2)/pageWidth)+1)
  }
}
