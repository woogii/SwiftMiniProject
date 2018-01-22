//
//  ViewController.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import JGProgressHUD
import CoreLocation
import Alamofire

// MARK: - SplashViewController: UIViewController
class SplashViewController: UIViewController {

  // MARK: - Property List
  private var currentLocation: CLLocation? {
    didSet {
      guard let location = currentLocation else { return }
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      viewModel.weatherInfoFetch(latitude: latitude, longitude: longitude)
    }
  }
  private let locationManager = CLLocationManager()
  private let hud: JGProgressHUD? = {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = Constants.Messages.Loading
    return hud
  }()
  lazy var viewModel: WeatherInfoViewModel = {
    return WeatherInfoViewModel()
  }()

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLocationManager()
    initViewModel()
  }

  private func initViewModel() {
    viewModel.segueToTabBarAfterFetchingClosure = { [weak self] () in
      DispatchQueue.main.async {
          self?.performSegue(withIdentifier: Constants.SegueIds.Modal.ShowMainTabBar, sender:   self)
      }
    }
    viewModel.updateLoadingStatusClosure = { [weak self] () in
      DispatchQueue.main.async {
        let isLoading = self?.viewModel.isLoading ?? false
        if isLoading {
          self?.hud?.show(in: (self?.view)!)
        } else {
          self?.hud?.dismiss()
        }
      }
    }
  }

  // MARK: - Configure Location Manager
  private func configureLocationManager() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  // MARK: - Prepare Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.SegueIds.Modal.ShowMainTabBar {
      guard let destinationVC = segue.destination as? MainTabBarController else {
        return
      }
      destinationVC.weatherInfoViewModel = viewModel
    }
  }
}

// MARK: - SplashViewController: CLLocationManagerDelegate
extension SplashViewController: CLLocationManagerDelegate {

  // MARK: - Authorization Status Change
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }

  // MARK: - Location Updates
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    // Update Current Location
    currentLocation = location
    // Reset Delegate
    manager.delegate = nil
    // Stop Location Manager
    manager.stopUpdatingLocation()
  }

  // MARK: - Location Update Error Handling
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if currentLocation == nil {
      currentLocation = CLLocation(latitude: Constants.DefaultLatitude, longitude: Constants.DefaultLongitude)
    }
    manager.delegate = nil
    manager.stopUpdatingLocation()
  }
}
