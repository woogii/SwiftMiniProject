//
//  Constants.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - Constants
struct Constants {

  // MARK: - API
  struct API {

    static let BaseUrl = "http://api.openweathermap.org/data/2.5"
    // MARK: - Parameter Keys
    struct ParameterKeys {
      static let Latitude = "lat"
      static let Longitude = "lon"
      static let Count = "cnt"
      static let AppId = "appid"
      static let Units = "units"
    }

    // MARK: - Parameter Values
    struct ParameterValues {
      static let ForcastApiMaximumCount = 39
      static let Metric = "metric"
    }

    // MARK: - Method List
    struct Methods {
      static let Weather = "/weather"
      static let Forecast = "/forecast"
    }
  }

  // MARK: - JSON Parsing Keys
  struct JSONParsingKeys {
    static let Name = "name"
    static let Weather = "weather"
    static let Main = "main"
    static let Temp = "temp"
    static let Pressure = "pressure"
    static let Wind = "wind"
    static let Speed = "speed"
    static let Degree = "deg"
    static let Clouds = "clouds"
    static let List = "list"
    static let City = "city"
    static let All = "all"
    static let Date = "dt"
    static let Rain = "rain"
    static let System = "sys"
    static let Country = "country"
    static let WithinThreeHours = "3h"
    static let Coordinate = "coord"
    static let Latitude = "lat"
    static let Longitude = "lon"
  }
  // MARK: - Title List
  struct Titles {
    static let TryButton = "Try again"
    static let OkButton = "OK"
    static let CancelButton = "Cancel"
    static let OpenSettingAlert = "Open Setting"
  }

  // MARK: - Segue ID List
  struct SegueIds {
    struct Modal {
      static let ShowMainTabBar = "showMainTabBar"
    }
  }

  // MARK: - Image Names
  struct Images {
    static let SunnyIcon = "Sunny"
    static let WindyIcon = "Windy"
    static let RainyIcon = "Rainy"
    static let LightningIcon = "Lightning"
    static let CloudyIcon = "Cloudy"
    static let SnowyIcon = "Snowy"
    static let Haze = "Haze"
  }

  // MARK: - Cell ID List
  struct CellIds {
    static let WeeklyWeahter = "weeklyWeatherTableViewCell"
  }

  // MARK: - Firebase Weather Information Key
  struct FirebaseWeatherInfoKey {
    static let Latitude = "Latitude"
    static let Longitude = "Longitude"
    static let LocationName = "Location"
    static let WeatherDesc = "WeatherDescription"
    static let Temperature = "Temperature"
    static let Pressure = "Pressure"
    static let WindSpeed = "WindSpeed"
    static let WindDegree = "WindDegree"
    static let Cloudiness = "Cloudiness"
    static let Time = "Time"
    static let CountryCode = "CountryCode"
    static var Precipitation = "Precipitation"
  }

  // MARK: - Format Specifiers
  struct FormatSpecifiers {
    static let Temperature = "%.0f °C"
    static let Pressure = "%.0f hPa"
    static let Precipitation = "%.1f mm"
    static let Cloudiness = "%d%%"
    static let WindSpeed = "%.1f m/s"
  }

  // MARK: - Message List
  struct Messages {
    static let Loading = "Loading..."
    static let OpenSettingAlert = "This app needs the user's location. Please change your location setting."
    static let ChangeLocationSetting = "Please change the location setting to display correct weather information"

    struct ParseError {
      static let WeeklyWeatherInfo = "WeeklyWeatherInfo property is missing"
      static let TodayWeatherInfo = "TodayWeatherInfo property is missing"
    }
  }

  // MARK: - Weather Related Units
  struct SharedWeatherMessage {
    static let Title = "Weather Information"
    static let CelciusPrefix = "Temperature: "
    static let CelciusSuffix = "°C"
    static let WindSpeedPrefix = "Wind Speed: "
    static let WindSpeedSuffix = "m/s"
    static let PressurePrefix = "Pressure: "
    static let PressureSuffix = "hPa"
  }

  static let UnExpectedTableViewCell = "Unexpected Table View Cell"
  static let ForecastUnits = 8
  static let FirebaseDateFormat = "yyyy-MM-dd"
  static let FirebaseChildReferencePath = "weatherInfo-list"
  static let NorthEast = "NE"
  static let NorthWest = "NW"
  static let SouthEast = "SE"
  static let SouthWest = "SW"
  static let UsLocale = "en_US"
  static let DayFormatInWeeklyWeatherVC = "EEEE"
  static let MinimumDistanceForLocationUpdate = 100.0
  static let DefaultLatitude = 33.25
  static let DefaultLongitude = 126.33
  static let DistanceFilter = 1000.0
}
