//
//  Constants.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 7..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants

struct Constants {
  
  
  static let DustInfoJson = "DustInfoJson"
  static let JsonFileExtension = "json"
  static let MicroGram = "µg/m³"
  static let PartsPerMillion = "ppm"
  
  // 0~30  :  Good,             Heart,      Blue
  // 31~80 :  Moderate,         Smile,      Green
  // 81~120:  Unhealthy,        Pokerface,  Orange
  // 121~200: Very Unhealthy,   Frown,       Red
  // 201~300: Hazardous,        Awful,      Black

  static let GoodLevel = 0...30
  static let ModerateLevel = 31...80
  static let UnhealthyLevel = 81...120
  static let VeryUnhealthyLevel = 121...200
  static let HazardousLevel = 201...300
  
  // MARK : - JSONResponseKeys
  
  struct JSONResponseKeys {
    
    static let Weather = "weather"
    static let Dust = "dust"
    static let PM10 = "pm10"
    static let O3 = "o3"
    static let NO2 = "no2"
    static let SO2 = "so2"
    static let CO = "co"
    static let Grade = "grade"
    static let Value = "value"
    static let Station = "station"
    static let Id = "id"
    static let Latitude = "latitude"
    static let Longitude = "longitude"
    static let LocationName = "locationName"
    static let TimeObservation = "timeObservation"
    
  }
  
  // MARK : - Colors
  
  struct Colors {
    
    static let DarkBlue = UIColor(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    static let DarkGreen = UIColor(colorLiteralRed: 0.0/255.0, green: 100.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let DarkOrange = UIColor(colorLiteralRed: 238.0/255.0, green: 118.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let DarkRed = UIColor(colorLiteralRed: 179.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 1.0)
    static let LightBlack = UIColor.black.withAlphaComponent(0.8)
    
  }
  
  
  
}

