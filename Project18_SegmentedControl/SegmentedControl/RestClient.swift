//
//  RestClient.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - RestClient 

class RestClient {

  // MARK : - Property
  
  static let sharedInstance = RestClient()
  typealias completionHanlder = (_ result:[String:Any]?, _ error:Error?)->Void
  var session : URLSession {
    return URLSession.shared
  }
  
  // MARK : - HTTP Get Request  
  
  func taskForGetMethod(_ method: String, parameters:[String:Any]?=nil, completionHandler:@escaping completionHanlder) {
    
    let escapedParamters = escapedParameters(parameters)
    
    let urlString = Constants.API.BaseUrl + Constants.API.Path + method +  escapedParamters
  
    guard let url = URL(string: urlString) else {
      return
    }
    
    session.dataTask(with: url) { (data,response, error) in
      
      if error != nil {
        #if DEBUG
          print(error?.localizedDescription as Any)
        #endif
        completionHandler(nil, error)
        
      } else {
      
        guard let returnData = data else {
          #if DEBUG
            print("data is not returned")
          #endif
          return
        }
    
        do {
          
          let jsonObject = try JSONSerialization.jsonObject(with: returnData, options: [])
          
          guard let jsonResult = jsonObject as? [String:Any] else {
            return
          }
          
          completionHandler(jsonResult, nil)
          
        } catch let error {
          print(error.localizedDescription)
        }
      
      }
      
    }.resume()
  
  }
  
  
  func escapedParameters(_ parameters:[String:Any]?)-> String {
    
    guard let parameters = parameters else {
      return ""
    }
    
    var escapedUrlParameters:String = "/"
    var keyValuePairs = [String]()
    
    for (key, value) in parameters {
      
      if let parameterValue = value as? String {
        
        if let encodingValue = parameterValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
          keyValuePairs.append(key + "=" + encodingValue)
        }
      }
    }
    
    escapedUrlParameters = "?" + keyValuePairs.joined(separator: "&")
    
    return escapedUrlParameters
    
  }
}
