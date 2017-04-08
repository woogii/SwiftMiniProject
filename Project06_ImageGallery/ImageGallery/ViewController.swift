//
//  ViewController.swift
//  ImageGallery
//
//  Created by siwook on 2017. 4. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController 

class ViewController: UIViewController {

  // MARK : - Property
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var upperImageView: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var favoriteImage: UIImageView!
  @IBOutlet weak var backImage: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var initialY :CGFloat?
  var initProfileY:CGFloat?
  var initProfileX:CGFloat?
  var initFavoriteY:CGFloat?
  var initFavoriteButtonY:CGFloat?
  var initBackY:CGFloat?
  var initialBackButtonY:CGFloat?
  var initProfileButtonY:CGFloat?
  var initProfileButtonX:CGFloat?
  let numberOfRows = 3
  let cellId = "customCell"
  let collectionViewCellId = "placeImageCollectionViewCell"
  let restaurantInfoList = RestaurantInfo.createRestaurantInfo()
  let gradientLayer = CAGradientLayer()
  var imageList = ["restaurant_detail1","restaurant_detail2","restaurant_detail3","restaurant_detail4","restaurant_detail5"]
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setInitialSubviewsCoordinate()
    configureProfileImageView()
    addGradientLayerToUpperImageView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  func addGradientLayerToUpperImageView() {
    
    gradientLayer.colors = [
      UIColor.black.withAlphaComponent(0.6).cgColor,
      UIColor.black.withAlphaComponent(0.6).cgColor]
    gradientLayer.locations = [1.0,0.0]
    upperImageView.layer.insertSublayer(gradientLayer, at: 0)
    gradientLayer.frame = upperImageView.bounds
    
  }
  
  func setInitialSubviewsCoordinate() {
    
    initialY = upperImageView.frame.origin.y
    initProfileY = profileImage.frame.origin.y
    initProfileX = profileImage.frame.origin.x
    initProfileButtonY = profileImage.frame.origin.y
    initProfileButtonX = profileImage.frame.origin.x
    initFavoriteY = favoriteImage.frame.origin.y
    initFavoriteButtonY = favoriteButton.frame.origin.y
    initBackY = backImage.frame.origin.y
    initialBackButtonY = backButton.frame.origin.y
    
  }
  
  func configureProfileImageView() {
    profileImage.layer.cornerRadius = profileImage.frame.size.width/2
    profileImage.layer.masksToBounds = true
    profileImage.layer.borderColor = UIColor.white.cgColor
    profileImage.image? = (profileImage.image?.withRenderingMode(.alwaysTemplate))!
    profileImage.tintColor = UIColor.white
  }
  
  // MARK : - Target Actions
  
  @IBAction func tapFavoriteButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: "favorite button tapped", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func tapProfileButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: "profile button tapped", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func tapBackButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: "back button tapped", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
}


// MARK : - ViewController : UITableViewDelegate, UITableViewDataSource

extension ViewController : UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
    cell.restaurant = restaurantInfoList[indexPath.row]
    return cell
  }
  
}

// MARK : - ViewController :  UICollectionViewDelegate, UICollectionViewDataSource

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! PlaceImageCollectionViewCell
    cell.placeImageView.image = UIImage(named:imageList[indexPath.row])
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
    let imageDetailPageVC = ImageDetailPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    imageDetailPageVC.imageUrlArray = self.imageList 
    imageDetailPageVC.selectedIndex = indexPath.item
    
    let transition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = kCATransitionFade
    navigationController?.view.layer.add(transition, forKey: nil)
    navigationController?.pushViewController(imageDetailPageVC, animated: false)

  }
  
}


// MARK : - ViewController :  UIScrollViewDelegate

extension ViewController : UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if scrollView is UICollectionView {
      
    } else {
      
      var modifiedFrame = upperImageView.frame
      var modifiedProfileFrame = profileImage.frame
      var modifiedProfileButtonFrame = profileButton.frame
      var modifiedFavoriteFrame = favoriteImage.frame
      var modifiedFavoriteButtonFrame = favoriteButton.frame
      var modifiedBackFrame =  backImage.frame
      var modifiedBackButtonFrame = backButton.frame
      
      modifiedFrame.origin.y = max(initialY!, scrollView.contentOffset.y - 160)
      modifiedProfileFrame.origin.y = max(initProfileY!, scrollView.contentOffset.y + 10 + 12)
      modifiedProfileFrame.origin.x = min(max(initProfileX!, scrollView.contentOffset.y - 40), initProfileX! + 40)
      modifiedProfileButtonFrame.origin.y = max(initProfileButtonY!, scrollView.contentOffset.y + 10 + 12)
      modifiedProfileButtonFrame.origin.x = min(max(initProfileButtonX!, scrollView.contentOffset.y - 40), initProfileX! + 40)
      modifiedFavoriteFrame.origin.y = max(initFavoriteY!, scrollView.contentOffset.y + 10 + 12)
      modifiedFavoriteButtonFrame.origin.y = max(initFavoriteY!, scrollView.contentOffset.y + 10 + 12)
      modifiedBackFrame.origin.y =  max(initBackY!, scrollView.contentOffset.y + 10 + 15)
      modifiedBackButtonFrame.origin.y =  max(initialBackButtonY!, scrollView.contentOffset.y + 10 + 15)
      
      upperImageView.frame = modifiedFrame
      profileImage.frame = modifiedProfileFrame
      favoriteImage.frame =  modifiedFavoriteFrame
      backImage.frame  = modifiedBackFrame
      backButton.frame = modifiedBackButtonFrame
      profileButton.frame = modifiedProfileButtonFrame
      favoriteButton.frame = modifiedFavoriteButtonFrame
      
    }
    
  }
  
  
}

// MARK : - UIView extension

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
