//
//  RestClientConvenience.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - RestClient Extension  

extension RestClient {

  // MARK : - Request Featured List
  
  func requestFeaturedList(listId:String, completionHandler:@escaping (_ result:[String:Any]?, _ error:Error?)->Void) {
    
    var parameters = [String:Any]()
    parameters[Constants.API.ParameterKeys.ApiKey] = ApiKey
    let method = Constants.API.Methods.List + "/" + "\(listId)"
    
    taskForGetMethod(method,parameters: parameters) { (result, error) in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, error)
      }
      
    }
  }
  
  func requestDiscoverMovieList(completionHandler:@escaping (_ result:[String:Any]?, _ error:Error?)->Void) {
    
    var parameters = [String:Any]()
    let method = Constants.API.Methods.DiscoverMovie
    parameters[Constants.API.ParameterKeys.ApiKey] = ApiKey
    parameters[Constants.API.ParameterKeys.Page] = 1
    
    
    taskForGetMethod(method,parameters: parameters) { (result, error) in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, error)
      }
      
    }
  }


  func requestConfigurationInfo(completionHandler:@escaping (_ result:[String:Any]?, _ error:Error?)->Void) {
    

    let method = Constants.API.Methods.Configuration
    var parameters = [String:Any]()
    parameters[Constants.API.ParameterKeys.ApiKey] = ApiKey
    
    taskForGetMethod(method,parameters: parameters) { (result, error) in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, error)
      }
      
    }
  }

  
}
