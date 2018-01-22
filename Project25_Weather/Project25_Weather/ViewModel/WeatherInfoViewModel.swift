//
//  WeatherInfoViewModel.swift
//  StrvWeather
//
//  Created by siwook on 2018. 1. 1..
//  Copyright © 2018년 siwook. All rights reserved.
//

import Foundation
import JGProgressHUD

struct WeeklyWeatherCellViewModel {
  let weather: String
  let temparature: String
  let iconImageName: String
  let date: String
}

struct TodayWeatherViewModel {
  var location: String = ""
  var temperature: String = ""
  var pressure: String = ""
  var weatherDesc: String = ""
  var windSpeed: String = ""
  var windDegree: String = ""
  var cloudiness: String = ""
  var precipitation: String = ""
  var iconImageName: String = ""
}

class WeatherInfoViewModel {

  let apiManager: ApiManagerProtocol
  private var weatherInfo: TodayWeatherInfo?
  private var weatherInfoList: [WeeklyWeatherInfo]?
  private let hud: JGProgressHUD? = {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = Constants.Messages.Loading
    return hud
  }()
  private let dayFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.DayFormatInWeeklyWeatherVC
    return dateFormatter
  }()
  var reloadTableViewClosure: (() -> Void)?
  var segueToTabBarAfterFetchingClosure: (() -> Void)?
  var updateLoadingStatusClosure: (() -> Void)?
  var updateTodayWeatherClosure: (() -> Void)?
  var showToastClosure: (() -> Void)?

  init(apiManager: ApiManagerProtocol = ApiManager(baseURL: Constants.API.BaseUrl)) {
    self.apiManager = apiManager
  }

  var weeklyWeatherCellViewModels: [WeeklyWeatherCellViewModel] = [WeeklyWeatherCellViewModel]() {
    didSet {
      self.reloadTableViewClosure?()
    }
  }

  var isFetched: Bool = false {
    didSet {
      self.segueToTabBarAfterFetchingClosure?()
    }
  }

  var isLoading: Bool = false {
    didSet {
      self.updateLoadingStatusClosure?()
    }
  }

  var numberOfCells: Int {
    return weeklyWeatherCellViewModels.count
  }

  var todayWeatherViewModel: TodayWeatherViewModel = TodayWeatherViewModel() {
    didSet {
      self.updateTodayWeatherClosure?()
    }
  }

  var toastMessage: String? {
    didSet {
      self.showToastClosure?()
    }
  }

  func getCellViewModel(at indexPath: IndexPath ) -> WeeklyWeatherCellViewModel {
    return weeklyWeatherCellViewModels[indexPath.row]
  }

  func weatherInfoFetch(latitude: Double, longitude: Double) {
    self.isLoading = true
    apiManager.dailyWeatherDataForLocation(latitude: latitude, longitude: longitude) { [weak self] (response, error) in
      self?.isLoading = false
      guard error == nil else { return }
      guard let weatherInfo = response else { return }
      self?.weatherInfo = weatherInfo
      self?.processFetchedTodayWeather(weatherInfo)

      // Call weekly weather api request
      self?.apiManager
        .weeklyWeatherDataForLocation(latitude: latitude, longitude: longitude) { [weak self] (response, error) in
          guard error == nil else { return }
          guard let weatherInfoList = response else { return }
          self?.processFetchedWeeklyWeather(weeklyWeather: weatherInfoList)
          self?.isFetched = true
      }
    }
  }

  private func processFetchedTodayWeather(_ weatherInfo: TodayWeatherInfo) {

    var tempViewModel = TodayWeatherViewModel()
    tempViewModel.location = weatherInfo.locationName + ", " +
      weatherInfo.countryCode.getCountryFromCountryCode()
    tempViewModel.temperature = String(format: Constants.FormatSpecifiers.Temperature,
                                           weatherInfo.temperature)
    tempViewModel.pressure = String(format: Constants.FormatSpecifiers.Pressure, weatherInfo.pressure)
    tempViewModel.weatherDesc = "\(weatherInfo.weatherDesc)"
    tempViewModel.windSpeed = String(format: Constants.FormatSpecifiers.WindSpeed, weatherInfo.windSpeed)
    tempViewModel.windDegree = weatherInfo.windDegree.windDegreeToString()
    tempViewModel.cloudiness = String(format: Constants.FormatSpecifiers.Cloudiness,
                                          weatherInfo.cloudiness)
    tempViewModel.precipitation = String(format: Constants.FormatSpecifiers.Precipitation,
                                             weatherInfo.precipitation)
    tempViewModel.iconImageName = weatherInfo.weatherDesc
    self.todayWeatherViewModel = tempViewModel
  }

  private func processFetchedWeeklyWeather(weeklyWeather: [WeeklyWeatherInfo] ) {
    self.weatherInfoList = weeklyWeather  // Cache
    var tempCellViewModel = [WeeklyWeatherCellViewModel]()

    for weather in weeklyWeather {
      tempCellViewModel.append(createCellViewModel(weatherInfo: weather))
    }
    self.weeklyWeatherCellViewModels = tempCellViewModel
  }

  private func createCellViewModel(weatherInfo: WeeklyWeatherInfo) -> WeeklyWeatherCellViewModel {
    let weather = weatherInfo.weatherDesc
    let temparature = String(format: Constants.FormatSpecifiers.Temperature,
                                   weatherInfo.temperature)
    let iconImageName = weatherInfo.weatherDesc
    let date = dayFormatter.string(from: weatherInfo.time)

    return WeeklyWeatherCellViewModel(weather: weather, temparature: temparature,
                                      iconImageName: iconImageName, date: date)
  }
}
