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
  
  var session : URLSession {
    return URLSession.shared
  }
  
  // MARK : - HTTP Get Request  
  
  func taskForGetMethod(_ method: String, parameters:[String:Any]?=nil, completionHandler:@escaping (_ result:[String:Any]?, _ error:Error?)->Void) {
    
    let urlString = Constants.API.BaseUrl + Constants.API.Path + method
    guard let url = URL(string: urlString) else {
      return
    }
    
    session.dataTask(with: url) { (data,response, error) in
      
      if error != nil {
        
        print(error?.localizedDescription as Any)
        completionHandler(nil, error)
        
      } else {
        
        guard let returnData = data else {
          print("data is not returned")
          return
        }
        
        do {
          
          let jsonObject = try JSONSerialization.jsonObject(with: returnData, options: .allowFragments)
          
          guard let jsonResult = jsonObject as? [String:Any] else {
            return
          }
          
          print(jsonResult)
          completionHandler(jsonResult, nil)
          
        } catch let error {
          print(error.localizedDescription)
        }
      
      }
      
    }.resume()
  
  }
  
}
