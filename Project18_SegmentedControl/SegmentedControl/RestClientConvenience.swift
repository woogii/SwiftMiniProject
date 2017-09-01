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

  
  func requestDiscoverMovieList(page:Int, completionHandler:@escaping completionHanlder) {
    
    var parameters = [String:Any]()
    let method = Constants.API.Methods.DiscoverMovie
    parameters[Constants.API.ParameterKeys.ApiKey] = ApiKey
    parameters[Constants.API.ParameterKeys.Page] = "\(page)"
    parameters[Constants.API.ParameterKeys.SortBy] = Constants.API.ParameterValues.PopularityDesc
    parameters[Constants.API.ParameterKeys.IncludeAdult] = Constants.API.StringFalse
    parameters[Constants.API.ParameterKeys.IncludeVideo] = Constants.API.StringFalse
    
    taskForGetMethod(method,parameters: parameters) { (result, error) in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, error)
      }
      
    }
  }
  
  func requestGenreMovieList(page:Int, genreId:Int, completionHandler:@escaping completionHanlder) {
    
    var parameters = [String:Any]()
    let method = Constants.API.Methods.DiscoverMovie
    parameters[Constants.API.ParameterKeys.ApiKey] = ApiKey
    parameters[Constants.API.ParameterKeys.Page] = "\(page)"
    parameters[Constants.API.ParameterKeys.SortBy] = Constants.API.ParameterValues.PopularityDesc
    parameters[Constants.API.ParameterKeys.IncludeAdult] = Constants.API.StringFalse
    parameters[Constants.API.ParameterKeys.IncludeVideo] = Constants.API.StringFalse
    parameters[Constants.API.ParameterKeys.WithGenres] = "\(genreId)"
    
    taskForGetMethod(method,parameters: parameters) { (result, error) in
      
      if let error = error {
        completionHandler(nil, error)
      } else {
        completionHandler(result, error)
      }
      
    }
  }

  
  func requestMovieListBasedOnUserSelection(method:String, page:Int, completionHandler:@escaping completionHanlder) {
    
    var parameters = [String:Any]()
    
    parameters[Constants.API.ParameterKeys.ApiKey] = ApiKey
    parameters[Constants.API.ParameterKeys.Page] = "\(page)"
    
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

  func requestGenresList(completionHandler:@escaping (_ result:[String:Any]?, _ error:Error?)->Void) {
    
    let method = Constants.API.Methods.GenreList
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
