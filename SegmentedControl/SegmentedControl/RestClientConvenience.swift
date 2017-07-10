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
    parameters[Constants.API.ParameterKeys.ListId] = listId
    let method = Constants.API.Methods.List
    
    taskForGetMethod(method,parameters: parameters) { (result, error) in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, error)
      }
      
    }
  }

}
