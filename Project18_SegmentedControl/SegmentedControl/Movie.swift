//
//  Movie.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 19..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - SerializaionError : Error

enum SerializaionError : Error {
  
  case missing(String)
  case invalid(String, Any)
  
}

// MARK : - Movie (Struct)

struct Movie {
  
  var overview:String
  var popularity:Double
  var posterPath:String
  var originalTitle: String
  var releaseDate:String
  var voteAverage:Float
  var voteCount:Int          
  typealias MovieQueryResult = (_ result:[Movie]?, _ error:Error?)->Void
  
  init(dictionary:[String:Any]) throws {
    
    guard let overview = dictionary[Constants.JSONParsingKeys.Overview] as? String else
    {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.OverviewMissing)
    }
  
    guard let popularity = dictionary[Constants.JSONParsingKeys.Popularity] as? Double else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.PopularityMissing)
    }
    
    guard let posterPath = dictionary[Constants.JSONParsingKeys.PosterPath] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.PosterPathMissing)
    }
    
    guard let originalTitle = dictionary[Constants.JSONParsingKeys.OriginalTitle] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.OriginalTitleMissing)
    }

    guard let releaseDate = dictionary[Constants.JSONParsingKeys.ReleaseDate] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.ReleaseDateMissing)
    }
    
    guard let voteAverage = dictionary[Constants.JSONParsingKeys.VoteAverage] as? Float else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.VoteAverageInvalid)
    }
     
    guard case (0.0...10.0) = voteAverage else {
      throw SerializaionError.invalid(Constants.SerializaionErrorDesc.VoteAverageInvalid, voteAverage)
    }
    
    guard let voteCount = dictionary[Constants.JSONParsingKeys.VoteCount] as?  Int else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.VoteCountMissing)
    }

    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.originalTitle = originalTitle
    self.releaseDate = releaseDate
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    
  }
  
  static func movieListPerGenre(page:Int, genreId:Int, completionHandler:@escaping MovieQueryResult) {
    
    RestClient.sharedInstance.requestGenreMovieList(page: page, genreId: genreId, completionHandler: { (results,error) in
      
      guard error == nil else {
        completionHandler(nil, error)
        return
      }
      
      let movieList = parseMovieListFromJSON(results: results)
      completionHandler(movieList, nil)
    })
  }
  
  static func discoveredMovieList(page:Int,completionHandler:@escaping MovieQueryResult) {
   
    RestClient.sharedInstance.requestDiscoverMovieList(page: page) { (results, error) in
      
      guard error == nil else {
        completionHandler(nil, error)
        return
      }
      
      let movieList = parseMovieListFromJSON(results: results)
      completionHandler(movieList, nil)
    }
  }
  
  
  static func movieListWithMethod(_ method:String, page:Int,completionHandler:@escaping MovieQueryResult) {
    
    RestClient.sharedInstance.requestMovieListBasedOnUserSelection(method:method, page: page) { (results, error) in
      
      guard error == nil else {
        completionHandler(nil, error)
        return
      }
      
      let movieList = parseMovieListFromJSON(results: results)
      completionHandler(movieList, nil)
    }
  }


  static func parseMovieListFromJSON(results:[String:Any]?)->[Movie]?{
    
    guard let wrappedResult = results, let dictArray = wrappedResult[Constants.JSONParsingKeys.Results] as? [[String:Any]] else {
      return nil
    }
    
    let movieList = dictArray.flatMap({ dict -> Movie? in
      do {
        return try Movie(dictionary: dict)
      } catch let error {
        print(error.localizedDescription)
        return nil
      }
    })
    
    return movieList
  }
  
}
