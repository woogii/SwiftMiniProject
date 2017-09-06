//
//  ViewController.swift
//  StickyHeaderViewDemo
//
//  Created by TeamSlogup on 2017. 3. 14..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit
import MapKit

// MARK : - ViewController: UIViewController

class ViewController: UIViewController {
  
  // MARK : - Property 
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var upperImageView: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var favoriteImage: UIImageView!
  @IBOutlet weak var backImage: UIImageView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  var initialY :CGFloat?
  var initProfileY:CGFloat?
  var initProfileX:CGFloat?
  var initFavoriteY:CGFloat?
  var initFavoriteButtonY:CGFloat?
  var initBackY:CGFloat?
  var initialBackButtonY:CGFloat?
  var initProfileButtonY:CGFloat?
  var initProfileButtonX:CGFloat?
  let restaurantInfoList = RestaurantInfo.createRestaurantInfo()
  let gradientLayer = CAGradientLayer()
  let regionRadius: CLLocationDistance = 1000
  let initialLocation = CLLocation(latitude: 37.539201, longitude: 126.995885)

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setInitialSubviewsCoordinate()
    configureProfileImageView()
    addGradientLayerToUpperImageView()
    centerMapOnLocation(location: initialLocation)
    addAnnotation()
  }
  
  // MARK : - Add an annotation
  
  func addAnnotation() {
    
    let place = Place(title: Constants.PlaceAnnotation.Title,
                          subtitle: Constants.PlaceAnnotation.SubTitle,
                          coordinate: initialLocation.coordinate)
    
    mapView.addAnnotation(place)
  }
  
  // MARK : - Set the center of the map
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  // MARK : - Add an opaque layer on UIImageView
  
  func addGradientLayerToUpperImageView() {
  
    gradientLayer.colors = [
      UIColor.black.withAlphaComponent(0.6).cgColor,
      UIColor.black.withAlphaComponent(0.6).cgColor]
    gradientLayer.locations = [1.0,0.0]
    upperImageView.layer.insertSublayer(gradientLayer, at: 0)
    gradientLayer.frame = upperImageView.bounds
    
  }

  // MARK : - Save initial coordinates for Subviews 
  
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
  
  // MARK : - Action Methods
  
  @IBAction func tapFavoriteButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: Constants.AlertMessage.ProfileButtonTapped, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: Constants.ButtonTitle.Cancel, style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)

  }
  
  @IBAction func tapProfileButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: Constants.AlertMessage.ProfileButtonTapped, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: Constants.ButtonTitle.Cancel, style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func tapBackButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: Constants.AlertMessage.BackButtonTapped, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: Constants.ButtonTitle.Cancel, style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
}

// MARK : - ViewController : UITableViewDataSource

extension ViewController : UITableViewDelegate, UITableViewDataSource {

  // MARK : - ViewController : UITableViewDataSource Methodss
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.NumberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.CustomCell, for: indexPath) as! CustomTableViewCell
    cell.restaurant = restaurantInfoList[indexPath.row]
    return cell
  }
  
}

// MARK : - ViewController : UIScrollViewDelegate

extension ViewController : UIScrollViewDelegate {
  
  // MARK : - UIScrollViewDelegate Method 
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    var modifiedFrame = upperImageView.frame
    var modifiedProfileFrame = profileImage.frame
    var modifiedProfileButtonFrame = profileButton.frame
    var modifiedFavoriteFrame = favoriteImage.frame
    var modifiedFavoriteButtonFrame = favoriteButton.frame
    var modifiedBackFrame =  backImage.frame
    var modifiedBackButtonFrame = backButton.frame
    
    // Values for the coordinates are assigned in ViewDidLoad
    
    modifiedFrame.origin.y = max(initialY!, scrollView.contentOffset.y - Constants.AdjustCoordPoint.BgImageViewY)
    modifiedProfileFrame.origin.y = max(initProfileY!, scrollView.contentOffset.y + Constants.AdjustCoordPoint.ProfileImageViewY)
    modifiedProfileFrame.origin.x = min(max(initProfileX!, scrollView.contentOffset.y - Constants.AdjustCoordPoint.ProfileImageViewX), initProfileX! + Constants.AdjustCoordPoint.ProfileImageViewX)
    modifiedProfileButtonFrame.origin.y = max(initProfileButtonY!, scrollView.contentOffset.y + Constants.AdjustCoordPoint.ProfileButtonX)
    modifiedProfileButtonFrame.origin.x = min(max(initProfileButtonX!, scrollView.contentOffset.y - Constants.AdjustCoordPoint.ProfileButtonY), initProfileX! + Constants.AdjustCoordPoint.ProfileButtonY)
    modifiedFavoriteFrame.origin.y = max(initFavoriteY!, scrollView.contentOffset.y + Constants.AdjustCoordPoint.FavoriteImageY)
    modifiedFavoriteButtonFrame.origin.y = max(initFavoriteY!, scrollView.contentOffset.y + Constants.AdjustCoordPoint.FavoriteImageY)
    modifiedBackFrame.origin.y =  max(initBackY!, scrollView.contentOffset.y + Constants.AdjustCoordPoint.BackImageY)
    modifiedBackButtonFrame.origin.y =  max(initialBackButtonY!, scrollView.contentOffset.y + Constants.AdjustCoordPoint.BackImageY)
    
    
    upperImageView.frame = modifiedFrame
    profileImage.frame = modifiedProfileFrame
    favoriteImage.frame =  modifiedFavoriteFrame
    backImage.frame  = modifiedBackFrame
    backButton.frame = modifiedBackButtonFrame
    profileButton.frame = modifiedProfileButtonFrame
    favoriteButton.frame = modifiedFavoriteButtonFrame
  }
  
  
}



