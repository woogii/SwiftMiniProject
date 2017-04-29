//
//  Helper.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Helper

class Helper {
  
  // MARK: Helper for Escaping Parameters in URL
  
  static func escapedParameters(_ parameters: [String:AnyObject]) -> String {
    
    if parameters.isEmpty {
      return ""
    } else {
      var keyValuePairs = [String]()
      
      for (key, value) in parameters {
        
        // make sure that it is a string value
        let stringValue = "\(value)"
        
        // escape it
        let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // append it
        keyValuePairs.append(key + "=" + "\(escapedValue!)")
        
      }
      
      return "?\(keyValuePairs.joined(separator: "&"))"
    }
  }
}

