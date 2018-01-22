//
//  UIImage+WeatherIcon.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

enum WeatherType: String {
  case windy = "Windy"
  case sunny = "Sunny"
  case clear = "Clear"
  case rain = "Rain"
  case haze = "Haze"
  case lightning = "Lightning"
  case clouds = "Clouds"
  case snow = "Snow"
}

// MARK: - UIImage Extension For Weather Icons
extension UIImage {
  class func imageForIcon(withName name: String) -> UIImage? {
    switch name {
    case WeatherType.sunny.rawValue, WeatherType.clear.rawValue:
      return UIImage(named: Constants.Images.SunnyIcon)
    case WeatherType.windy.rawValue:
      return UIImage(named: Constants.Images.WindyIcon)
    case WeatherType.rain.rawValue:
      return UIImage(named: Constants.Images.RainyIcon)
    case WeatherType.lightning.rawValue:
      return UIImage(named: Constants.Images.LightningIcon)
    case WeatherType.clouds.rawValue:
      return UIImage(named: Constants.Images.CloudyIcon)
    case WeatherType.snow.rawValue:
      return UIImage(named: Constants.Images.SnowyIcon)
    case WeatherType.haze.rawValue:
      return UIImage(named: Constants.Images.Haze)
    default: return UIImage(named: Constants.Images.SunnyIcon)
    }
  }
}
