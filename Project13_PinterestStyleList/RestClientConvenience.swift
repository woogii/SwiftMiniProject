//
//  MindvalleyImageConvenience.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 19..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Convenient methods For requesting data

extension RestClient {
  
  // MARK : - Fetch Image List 
  
  func fetchImageList(urlString: String, parameters: [String : AnyObject]?=nil, size:Int?=nil, completionHandler: @escaping CompletionHandler)->URLSessionDataTask? {
    
    let task = taskForGetImageWith(urlString: urlString, parameters: nil, size: size, completionHandler: { result, error in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, nil)
      }
    })
    
    return task
  }

  // MARK : - Fetch General Data 
  
  func fetchJSONData(urlString: String, parameters: [String : AnyObject]?=nil, size:Int?=nil, completionHandler: @escaping CompletionHandler)->URLSessionDataTask? {
    
    let task = taskForGetData(urlString: urlString, parameters: nil, size: size, completionHandler: { result, error in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        
        // Code that process JSON result can be written here 
        
        completionHandler(result, nil)
      }
    })
    
    return task
  }

  
  
  
  
}
