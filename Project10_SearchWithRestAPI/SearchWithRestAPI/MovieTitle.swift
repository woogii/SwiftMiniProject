//
//  MovieTitle.swift
//  SearchWithRestAPI
//
//  Created by siwook on 2017. 8. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - MovieTitle

struct Movie {

  // MARK : - Property 
  
  var title:String
  var overview:String
  var releaseDate:String
  
  enum SerializationError:Error {
    case missing(String)
  }
  typealias QueryResult = (_ result:[Movie]?, _ error:Error?)->Void
  

  // MARK : - Initialization 
  
  init(dictionary:[String:Any]) throws {
    
    guard let title = dictionary[Constants.TMDBResponseKeys.Title] as? String else {
      throw SerializationError.missing("")
    }
    
    guard let overview = dictionary[Constants.TMDBResponseKeys.Title] as? String else {
      throw SerializationError.missing("")
    }
    
    guard let releaseDate = dictionary[Constants.TMDBResponseKeys.Title] as? String else {
      throw SerializationError.missing("")
    }
    
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
  }
  
  // MARK : - Request Upcoming Movie List
  
  static func requestUpcomingMovieList(completionHandler:QueryResult) {
    
    let upcomingMovieListUrl:URL? = createURLBasedOnRequestType(searchKeyword: nil)
    
    guard let url = upcomingMovieListUrl else {
      return
    }
  
    URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
      
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
        print(json as Any)
      }
      
    }).resume()
  }
  
  static func performSearch(keyword :String) {
    
    let searchUrl = createURLBasedOnRequestType(searchKeyword: keyword)
    
    guard let _ = searchUrl else {
      return
    }
    
  }
  
  // MARK : - Create URL for API Request 
  
  static func createURLBasedOnRequestType(searchKeyword:String?)-> URL? {
    
    var urlComponents:URLComponents?
    
    let apiQuery = URLQueryItem(name: Constants.TMDBParameterKeys.ApiKey, value: ApiKey)
    
    if searchKeyword == nil {
      urlComponents = URLComponents(string:Constants.TMDB.ApiBaseURL + Constants.TMDB.APiPathForUpcoming)
      urlComponents?.queryItems = [apiQuery]
    } else {
      urlComponents = URLComponents(string:Constants.TMDB.ApiBaseURL + Constants.TMDB.ApiPathForSearch)
      let searchQuery = URLQueryItem(name: Constants.TMDBParameterKeys.SearchKeyword, value: searchKeyword)
      urlComponents?.queryItems = [apiQuery, searchQuery]
    }
    
    return urlComponents?.url
  }
  
  
  
  
}
