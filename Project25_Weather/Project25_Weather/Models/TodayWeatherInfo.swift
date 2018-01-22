//
//  TodayWeatherInfo.swift
//  StrvWeather
//
//  Created by siwook on 2017. 12. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - SerializationError
enum SerializationError: Error {
  case missing(String)
}

// MARK: - TodayWeatherInfo
struct TodayWeatherInfo {

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
  init(dictionary: [String:Any]) throws {

    guard let coordinate = dictionary[Constants.JSONParsingKeys.Coordinate] as? [String:Any],
      let latitude = coordinate[Constants.JSONParsingKeys.Latitude] as? Double,
      let longitude = coordinate[Constants.JSONParsingKeys.Longitude] as? Double,
      let locationName = dictionary[Constants.JSONParsingKeys.Name] as? String,
      let weatherInfo = dictionary[Constants.JSONParsingKeys.Weather] as? [[String:Any]],
      let weatherDesc = weatherInfo[0][Constants.JSONParsingKeys.Main] as? String,
      let main = dictionary[Constants.JSONParsingKeys.Main] as? [String:Any],
      let temperature = main[Constants.JSONParsingKeys.Temp] as? Double,
      let pressure = main[Constants.JSONParsingKeys.Pressure] as? Double,
      let wind = dictionary[Constants.JSONParsingKeys.Wind] as? [String:Any],
      let windSpeed = wind[Constants.JSONParsingKeys.Speed] as? Double,
      let windDegree = wind[Constants.JSONParsingKeys.Degree] as? Double,
      let clouds = dictionary[Constants.JSONParsingKeys.Clouds] as? [String: Any],
      let cloudiness = clouds[Constants.JSONParsingKeys.All] as? Int,
      let system = dictionary[Constants.JSONParsingKeys.System] as? [String:Any],
      let countryCode = system[Constants.JSONParsingKeys.Country] as? String,
      let timeInfo = dictionary[Constants.JSONParsingKeys.Date] as? Double else {
        throw SerializationError.missing(Constants.Messages.ParseError.TodayWeatherInfo)
    }

    self.latitude = latitude
    self.longitude = longitude
    self.locationName = locationName
    self.weatherDesc = weatherDesc
    self.temperature = temperature
    self.pressure = pressure
    self.windSpeed = windSpeed
    self.windDegree = windDegree
    self.countryCode = countryCode
    self.time = Date(timeIntervalSince1970: timeInfo)

    // There is no data such as 'chance of rain'. I add the property called  'cloudiness'
    // to replace the 'chace of rain'.
    self.cloudiness = cloudiness
    // The value of the precipitation property is initially set '0.0' as default if
    // 'rain' dictionary does not exist in JSON response. If exists, the precipitation
    // value will be stored after parsing
    guard let rainInfo = dictionary[Constants.JSONParsingKeys.Rain] as? [String:Any],
      let precipitation = rainInfo[Constants.JSONParsingKeys.WithinThreeHours] as? Double else {
        return
    }
    self.precipitation = precipitation
  }
}
