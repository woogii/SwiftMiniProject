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
  
  var grade:String
  var value :String
  var longitude:String
  var latitude:String
  var locationName:String
  var timeObservation : String
  
  // MARK : - Initialization 
  
  init(dictionary:[String:Any]) {
  
    self.locationName  = dictionary[Constants.JSONResponseKeys.LocationName] as? String ?? ""
    self.grade = dictionary[Constants.JSONResponseKeys.Grade] as? String ?? ""
    self.value = dictionary[Constants.JSONResponseKeys.Value] as? String ?? ""
    self.longitude = dictionary[Constants.JSONResponseKeys.Longitude] as? String ?? ""
    self.latitude = dictionary[Constants.JSONResponseKeys.Latitude] as? String ?? ""
    self.timeObservation  = dictionary[Constants.JSONResponseKeys.TimeObservation] as? String ?? ""
    
  }
  
}
