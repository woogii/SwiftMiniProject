//
//  ViewController.swift
//  StickyHeaderViewDemo
//
//  Created by TeamSlogup on 2017. 3. 14..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
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
  let numberOfRows = 3
  let cellId = "customCell"
  let restaurantInfoList = RestaurantInfo.createRestaurantInfo()
  let gradientLayer = CAGradientLayer()
  let regionRadius: CLLocationDistance = 1000
  let initialLocation = CLLocation(latitude: 37.539201, longitude: 126.995885)

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setInitialSubviewsCoordinate()
    configureProfileImageView()
    addGradientLayerToUpperImageView()
    centerMapOnLocation(location: initialLocation)
    addAnnotation()
  }
  
  func addAnnotation() {
    
    let place = Place(title: "Restaurant",
                          subtitle: "Brunch",
                          coordinate: CLLocationCoordinate2D(latitude: 37.539201, longitude: 126.995885))
    
    mapView.addAnnotation(place)
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
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


extension ViewController : UIScrollViewDelegate {
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
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



