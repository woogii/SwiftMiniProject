//
//  WeeklyWeatherViewController.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - WeeklyWeatherViewController: UIViewController
class WeeklyWeatherViewController: UIViewController {

  // MARK: - Property List
  @IBOutlet weak var tableView: UITableView!
  var todayWeatherInfo: TodayWeatherInfo!
  var weeklyWeatherInfoList: [WeeklyWeatherCellViewModel]!
  var weatherInfoViewModel: WeatherInfoViewModel!
  private let locationManager = CLLocationManager()
  private var currentLocation: CLLocation? {
    didSet {
      requestWeeklyWeather()
    }
  }

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationBar()
    updateView()
    setupNotificationHandling()
    setupRefreshControl()
    configureLocationManager()
    initViewModel()
  }

  private func initViewModel() {
    self.weatherInfoViewModel.reloadTableViewClosure = {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }

    self.weatherInfoViewModel.showToastClosure = { [weak self] in
      DispatchQueue.main.async {
        guard let message = self?.weatherInfoViewModel.toastMessage else { return }
        if message == Constants.Messages.ChangeLocationSetting {
          self?.view.makeToast(message, duration: 5.0, position: .bottom, completion: { touched in
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

  // MARK: - Configure Location Manager
  private func configureLocationManager() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = Constants.DistanceFilter
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    displayLocationAuthStatus()
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
    // Add the observer that checks whether the app has become active
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

  // MARK: - Request Weekly Weather
  private func requestWeeklyWeather() {
    guard let currentLocation = currentLocation else {
      self.tableView.refreshControl?.endRefreshing()
      return
    }
    let latitude = currentLocation.coordinate.latitude
    let longitude = currentLocation.coordinate.longitude
    weatherInfoViewModel.weatherInfoFetch(latitude: latitude, longitude: longitude)
  }

  // MARK: - Configure Navigation Bar
  private func configureNavigationBar() {
    setNavigationBarTitle()
  }
  // MARK: - Set NavigationBar Title
  private func setNavigationBarTitle() {
    self.navigationItem.title = weatherInfoViewModel.todayWeatherViewModel.location
  }

  // MARK: - Update Subviews 
  private func updateView() {
    tableView.refreshControl?.endRefreshing()
    tableView.reloadData()
  }

  // MARK: - Set up RefreshControl
  private func setupRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl
      .addTarget(self, action: #selector(WeeklyWeatherViewController.didRefresh(sender:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  // MARK: - RefreshControl Selector
  @objc func didRefresh(sender: UIRefreshControl) {
    tableView.refreshControl?.beginRefreshing()
    requestWeeklyWeather()
  }

  // MARK: - Deinitialization
  deinit {
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self)
  }
}

// MARK: - WeeklyWeatherViewController: UITableViewDataSource
extension WeeklyWeatherViewController: UITableViewDataSource {

  // MARK: - UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherInfoViewModel.weeklyWeatherCellViewModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: Constants.CellIds.WeeklyWeahter,
                           for: indexPath) as? WeeklyWeatherTableViewCell else {
                            fatalError(Constants.UnExpectedTableViewCell)
    }
    let cellViewModel = weatherInfoViewModel.getCellViewModel(at: indexPath)
    cell.dayLabel.text = cellViewModel.date
    cell.temparatureLabel.text = cellViewModel.temparature
    cell.weatherIconImageView.image = UIImage.imageForIcon(withName: cellViewModel.iconImageName)
    cell.weatherLabel.text = cellViewModel.weather

    return cell
  }
}

// MARK: - WeeklyWeatherViewController: CLLocationManagerDelegate
extension WeeklyWeatherViewController: CLLocationManagerDelegate {

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
    self.view.makeToast(error.localizedDescription, duration: 1.5, position: .bottom, completion: nil)
  }
}
