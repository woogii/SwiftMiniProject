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
      throw SerializationError.missing(Constants.SerializationErrorDesc.TitleMissing)
    }
    
    guard let overview = dictionary[Constants.TMDBResponseKeys.Overview] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.OverviewMissing)
    }
    
    guard let releaseDate = dictionary[Constants.TMDBResponseKeys.ReleaseDate] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.ReleaseDateMissing)
    }
    
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
  }
  
  // MARK : - Request Upcoming Movie List
  
  static func requestMovieList(searchKeyword:String?, completionHandler:@escaping QueryResult) {
    
    let upcomingMovieListUrl:URL? = createURLBasedOnRequestType(searchKeyword: searchKeyword)
    
    guard let url = upcomingMovieListUrl else {
      return
    }
  
    URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
      
      var movieList:[Movie] = []
      
      if let data = data,
      let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let dictArray = json?[Constants.TMDBResponseKeys.Results] as? [[String:Any]] {
        
        for case let dict in dictArray {
          guard let movie = try? Movie(dictionary: dict) else {
            return
          }
          movieList.append(movie)
        }
        
        completionHandler(movieList, error)
      }
      
    }).resume()
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
