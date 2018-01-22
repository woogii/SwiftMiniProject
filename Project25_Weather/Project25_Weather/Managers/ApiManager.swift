//
//  DataManager.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

protocol ApiManagerProtocol {
  // MARK: - CompletionHandler TypeAlias List
  typealias TodayDataCompletion = (TodayWeatherInfo?, NSError?) -> Void
  typealias WeeklyDataCompletion = ([WeeklyWeatherInfo]?, NSError?) -> Void
  typealias RequestCompletion = ([String: Any]?, NSError?) -> Void

  func dailyWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping TodayDataCompletion)
  func weeklyWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeeklyDataCompletion)
}

// MARK: - ApiManager
final class ApiManager: ApiManagerProtocol {

  // MARK: - Property List
  private let baseURL: String

  // MARK: - Initialization
  init(baseURL: String) {
    self.baseURL = baseURL
  }

  // MARK: - API Get Request
  func weatherAPIGetRequest(url: URL, parameters: [String: String], completion: @escaping RequestCompletion) {

    Alamofire.request(url, method: .get,
                      parameters: parameters,
                      encoding: URLEncoding(destination: .queryString))
      .responseJSON { (response) -> Void in
        switch response.result {
        case .success:
          guard let jsonValue = response.result.value as? [String: Any] else {
            return
          }
          completion(jsonValue, nil)
        case .failure(let error):
          completion(nil, error as NSError)
        }
    }
  }

  // MARK: - Request Daily Weather Data
  func dailyWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping TodayDataCompletion) {
    let apiURL = self.baseURL + Constants.API.Methods.Weather
    guard let url = URL(string: apiURL) else { return }

    let parameters = [Constants.API.ParameterKeys.Latitude: "\(latitude)",
      Constants.API.ParameterKeys.Longitude: "\(longitude)",
      Constants.API.ParameterKeys.Units: Constants.API.ParameterValues.Metric,
      Constants.API.ParameterKeys.AppId: AppId]

    weatherAPIGetRequest(url: url, parameters: parameters) { (jsonResponse, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }
      guard let jsonResponse = jsonResponse else { return }

      do {
        let weatherInfo = try TodayWeatherInfo(dictionary: jsonResponse)
        completion(weatherInfo, nil)
      } catch {
        completion(nil, error as NSError)
      }
    }
  }

  // MARK: - Request Weekly Weather Data
  func weeklyWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeeklyDataCompletion) {
    let apiURL = self.baseURL + Constants.API.Methods.Forecast
    guard let url = URL(string: apiURL) else { return }
    let parameters =  [Constants.API.ParameterKeys.Latitude: "\(latitude)",
      Constants.API.ParameterKeys.Longitude: "\(longitude)",
      Constants.API.ParameterKeys.Units: Constants.API.ParameterValues.Metric,
      Constants.API.ParameterKeys.Count: "\(Constants.API.ParameterValues.ForcastApiMaximumCount)",
      Constants.API.ParameterKeys.AppId: AppId]

    weatherAPIGetRequest(url: url, parameters: parameters) { (response, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }
      guard let jsonResponse = response,
        let dictArray = jsonResponse[Constants.JSONParsingKeys.List] as? [[String:Any]],
        let cityInfo = jsonResponse[Constants.JSONParsingKeys.City] as? [String: Any],
        let locationName = cityInfo[Constants.JSONParsingKeys.Name] as? String,
        let countryCode = cityInfo[Constants.JSONParsingKeys.Country] as? String
        else {
          return
      }

      var weatherInfoList = [WeeklyWeatherInfo]()
      // We can search weather forecast for 5 days with data every 3 hours.
      // First, we receive the server response that includes maximum of 39
      // dictionaries related to weather information calculated evey 3 hours
      // and extracts only five (0, 8, 16, 24, 32 indexes) of them to display
      // weekly weather information
      for i in 0..<dictArray.count where (i%Constants.ForecastUnits == 0) {
        do {
          let weeklyWeather = try WeeklyWeatherInfo(latitude: latitude, longitude: longitude,
              locationName: locationName, countryCode: countryCode, dictionary: dictArray[i])
          weatherInfoList.append(weeklyWeather)
        } catch {
          completion(nil, error as NSError)
          return
        }
      }

      completion(weatherInfoList, nil)
    }
  }
}
