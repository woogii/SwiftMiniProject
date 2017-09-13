//
//  DustInfo.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 6..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - DustInfo

struct DustInfo {

  // MARK : - Property

  var pm10Grade: String
  var pm10Value: Double
  var o3Grade: String
  var o3Value: Double
  var no2Grade: String
  var no2Value: Double
  var so2Grade: String
  var so2Value: Double
  var coGrade: String
  var coValue: Double
  var longitude: String
  var latitude: String
  var locationName: String
  var timeObservation: String

  // MARK : - Initialization 

  init?(dictionary: [String:Any]) {

    self.locationName  = dictionary[Constants.JSONResponseKeys.LocationName] as? String ?? ""

    guard let pm10Dict = dictionary[Constants.JSONResponseKeys.PM10] as? [String:Any] else {
      return nil
    }

    self.pm10Grade = pm10Dict[Constants.JSONResponseKeys.Grade] as? String ?? ""
    self.pm10Value = pm10Dict[Constants.JSONResponseKeys.Value] as? Double ?? 0

    guard let o3Dict = dictionary[Constants.JSONResponseKeys.O3Key] as? [String:Any] else {
      return nil
    }

    self.o3Grade = o3Dict[Constants.JSONResponseKeys.Grade] as? String ?? ""
    self.o3Value = o3Dict[Constants.JSONResponseKeys.Value] as? Double ?? 0

    guard let no2Dict = dictionary[Constants.JSONResponseKeys.NO2] as? [String:Any] else {
      return nil
    }

    self.no2Grade = no2Dict[Constants.JSONResponseKeys.Grade] as? String ?? ""
    self.no2Value = no2Dict[Constants.JSONResponseKeys.Value] as? Double ?? 0

    guard let so2Dict = dictionary[Constants.JSONResponseKeys.SO2] as? [String:Any] else {
      return nil
    }

    self.so2Grade = so2Dict[Constants.JSONResponseKeys.Grade] as? String ?? ""
    self.so2Value = so2Dict[Constants.JSONResponseKeys.Value] as? Double ?? 0

    guard let coDict = dictionary[Constants.JSONResponseKeys.COKey] as? [String:Any] else {
      return nil
    }

    self.coGrade = coDict[Constants.JSONResponseKeys.Grade] as? String ?? ""
    self.coValue = coDict[Constants.JSONResponseKeys.Value] as? Double ?? 0

    self.longitude = dictionary[Constants.JSONResponseKeys.Longitude] as? String ?? ""
    self.latitude = dictionary[Constants.JSONResponseKeys.Latitude] as? String ?? ""
    self.timeObservation  = dictionary[Constants.JSONResponseKeys.TimeObservation] as? String ?? ""

  }

}
