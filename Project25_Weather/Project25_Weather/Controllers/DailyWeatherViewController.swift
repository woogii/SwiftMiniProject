//
//  DailyWeatherViewController.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Toast_Swift
import CoreLocation

// MARK: - DailyWeatherViewController: UIViewController
class DailyWeatherViewController: UIViewController {

  // MARK: - Property List
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var weatherInfoLabel: UILabel!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var precipitationLabel: UILabel!
  @IBOutlet weak var cloudinessLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var windDegreeLabel: UILabel!
  //var weatherInfo: TodayWeatherInfo!
  var weatherInfo: TodayWeatherViewModel!
  private let locationManager = CLLocationManager()
  private var currentLocation: CLLocation? {
    didSet {
      requestDailyWeather()
    }
  }
  var weatherInfoViewModel: WeatherInfoViewModel!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLocationManager()
    setupNotificationHandling()
    initViewModel()
  }

  private func initViewModel() {
    updateView()
    weatherInfoViewModel.updateTodayWeatherClosure = { [weak self] in
      DispatchQueue.main.async {
        self?.updateView()
      }
    }
    weatherInfoViewModel.showToastClosure = { [weak self] in
      DispatchQueue.main.async {
        guard let message = self?.weatherInfoViewModel.toastMessage else { return }
        if message == Constants.Messages.ChangeLocationSetting {
          self?.view.makeToast(message,
                               duration: 5.0, position: .bottom, completion: { touched in
                                // If message is touched, move to the setting screen
                                if touched {
                                  guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
                                    return
                                  }
                                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
          })
        } else {
          self?.view.makeToast(message, duration: 1.5, position: .bottom, completion: nil)
        }
      }
    }
  }

  private func updateView() {
    locationLabel.text = weatherInfoViewModel.todayWeatherViewModel.location
    tempLabel.text = weatherInfoViewModel.todayWeatherViewModel.temperature
    pressureLabel.text = weatherInfoViewModel.todayWeatherViewModel.pressure
    weatherInfoLabel.text = weatherInfoViewModel.todayWeatherViewModel.weatherDesc
    windLabel.text = weatherInfoViewModel.todayWeatherViewModel.windSpeed
    windDegreeLabel.text = weatherInfoViewModel.todayWeatherViewModel.windDegree
    cloudinessLabel.text = weatherInfoViewModel.todayWeatherViewModel.cloudiness
    precipitationLabel.text = weatherInfoViewModel.todayWeatherViewModel.precipitation
    weatherIconImageView.image =
      UIImage.imageForIcon(withName: weatherInfoViewModel.todayWeatherViewModel.iconImageName)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    displayLocationAuthStatus()
  }

  // MARK: - Configure Location Manager
  private func configureLocationManager() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = Constants.DistanceFilter
  }

  // MARK: - Display Auth Status
  private func displayLocationAuthStatus() {
    if !isLocationAuthorized() {
      self.weatherInfoViewModel.toastMessage = Constants.Messages.ChangeLocationSetting
    }
  }

  // MARK: - Auth Status Check
  private func isLocationAuthorized() -> Bool {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      return true
    default:
      return false
    }
  }

  // MARK: - Add Observer
  private func setupNotificationHandling() {
    let notificationCenter = NotificationCenter.default
    notificationCenter
      .addObserver(self, selector: #selector(DailyWeatherViewController.applicationDidBecomeActive(notification:)),
                   name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
  }

  // MARK: - Notification Selector
  @objc func applicationDidBecomeActive(notification: Notification) {
    // This function gets called when the app has become active
    requestLocation()
  }

  // MARK: - Request Location
  private func requestLocation() {
    // Configure Location Manager
    locationManager.delegate = self
    if isLocationAuthorized() {
      locationManager.startUpdatingLocation()
    } else {
      // Request Authorization
      locationManager.requestWhenInUseAuthorization()
    }
  }

  // MARK: - Request Daily Weather
  private func requestDailyWeather() {

    guard let currentLocation = currentLocation else { return }
    let latitude = currentLocation.coordinate.latitude
    let longitude = currentLocation.coordinate.longitude
    weatherInfoViewModel.weatherInfoFetch(latitude: latitude, longitude: longitude)
  }
  
  // MARK: - Deinitialization
  deinit {
    // Remove Observer
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self)
  }

  // MARK: - Target Action Method
  @IBAction func shareButtonTapped(_ sender: Any) {
    let activityController = UIActivityViewController(activityItems: [createSharedMessage()],
                                                      applicationActivities: nil)
    present(activityController, animated: true, completion: nil)
  }

  // MARK: - Create Shared Message
  private func createSharedMessage() -> String {
    return Constants.SharedWeatherMessage.Title + "\n" +
      self.weatherInfoViewModel.todayWeatherViewModel.location + "\n"
      + Constants.SharedWeatherMessage.CelciusPrefix +
      "\(self.weatherInfoViewModel.todayWeatherViewModel.temperature) "
      + "\n" + Constants.SharedWeatherMessage.WindSpeedPrefix
      + "\(self.weatherInfoViewModel.todayWeatherViewModel.windSpeed)" + "\n"
      + Constants.SharedWeatherMessage.PressurePrefix
      + "\(self.weatherInfoViewModel.todayWeatherViewModel.pressure)"
  }
}

// MARK: - DailyWeatherViewController: CLLocationManagerDelegate
extension DailyWeatherViewController: CLLocationManagerDelegate {

  // MARK: - Location Updates
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    guard let newLocation = locations.first else { return }

    currentLocation = newLocation
    // Stop Location Manager
    manager.stopUpdatingLocation()
    // Reset Delegate
    manager.delegate = nil
  }

  // MARK: - Location Update Error Handling
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    self.weatherInfoViewModel.toastMessage = error.localizedDescription
  }
}
