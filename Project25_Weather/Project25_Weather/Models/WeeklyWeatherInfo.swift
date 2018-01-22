//
//  WeeklyWeatherInfo.swift
//  StrvWeather
//
//  Created by siwook on 2017. 12. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - WeeklyWeatherInfo
struct WeeklyWeatherInfo {

  // MARK: - Property List
  let latitude: Double
  let longitude: Double
  let locationName: String
  let weatherDesc: String
  let temperature: Double
  let pressure: Double
  let windSpeed: Double
  let windDegree: Double
  let cloudiness: Int
  let time: Date
  let countryCode: String
  var precipitation: Double = 0.0
  private let dayFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.FirebaseDateFormat
    return dateFormatter
  }()

  // MARK: - Initialization
  init(latitude: Double, longitude: Double, locationName: String, countryCode: String,
       dictionary: [String:Any]) throws {

    guard let main = dictionary[Constants.JSONParsingKeys.Main] as? [String:Any],
      let temperature = main[Constants.JSONParsingKeys.Temp] as? Double,
      let weatherInfo = dictionary[Constants.JSONParsingKeys.Weather] as? [[String:Any]],
      let weatherDesc = weatherInfo[0][Constants.JSONParsingKeys.Main] as? String,
      let pressure = main[Constants.JSONParsingKeys.Pressure] as? Double,
      let wind = dictionary[Constants.JSONParsingKeys.Wind] as? [String:Any],
      let windSpeed = wind[Constants.JSONParsingKeys.Speed] as? Double,
      let windDegree = wind[Constants.JSONParsingKeys.Degree] as? Double,
      let clouds = dictionary[Constants.JSONParsingKeys.Clouds] as? [String: Any],
      let cloudiness = clouds[Constants.JSONParsingKeys.All] as? Int,
      let timeInfo = dictionary[Constants.JSONParsingKeys.Date] as? Double else {
        throw SerializationError.missing(Constants.Messages.ParseError.WeeklyWeatherInfo)
    }
    self.locationName = locationName
    self.latitude = latitude
    self.longitude = longitude
    self.temperature = temperature
    self.weatherDesc = weatherDesc
    self.pressure = pressure
    self.windSpeed = windSpeed
    self.windDegree = windDegree
    self.cloudiness = cloudiness
    self.countryCode = countryCode
    self.time = Date(timeIntervalSince1970: timeInfo)

    guard let rainInfo = dictionary[Constants.JSONParsingKeys.Rain] as? [String:Any],
      let precipitation = rainInfo[Constants.JSONParsingKeys.WithinThreeHours] as? Double else {
        return
    }
    self.precipitation = precipitation
  }
}
