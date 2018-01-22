//
//  MainTabBarController.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK: - MainTabBarController: UITabBarController
class MainTabBarController: UITabBarController {

  // MARK: - Property List
  var weatherInfoViewModel: WeatherInfoViewModel!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    passDataToDailyAndWeeklyWeatherVCs()
  }

  private func passDataToDailyAndWeeklyWeatherVCs() {
    guard let dailyWeatherNavVC = self.viewControllers?[0] as? UINavigationController,
      let dailyWeatherVC = dailyWeatherNavVC.topViewController as? DailyWeatherViewController,
      let weeklyWeatherNavVC = self.viewControllers?[1] as? UINavigationController,
      let weeklyWeatherVC = weeklyWeatherNavVC.topViewController as? WeeklyWeatherViewController else {
        return
    }
    dailyWeatherVC.weatherInfoViewModel = self.weatherInfoViewModel
    weeklyWeatherVC.weatherInfoViewModel = self.weatherInfoViewModel
  }
}
