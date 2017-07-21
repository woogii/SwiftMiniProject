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
  
  init() {
    overview = ""
    popularity = 0.0
    posterPath = ""
    originalTitle = ""
    releaseDate = ""
    voteAverage = 0.0
    voteCount = 0
  }
  
  init?(dictionary:[String:Any]) throws {
    
    guard let overview = dictionary[Constants.JSONParsingKeys.Overview] as? String else
    {
      throw SerializaionError.missing(Constants.JSONParsingKeys.Overview)
    }
    self.overview = overview

    guard let popularity = dictionary[Constants.JSONParsingKeys.Popularity] as? Double else {
      throw SerializaionError.missing(Constants.JSONParsingKeys.Popularity)
    }
    self.popularity = popularity
    
    guard let posterPath = dictionary[Constants.JSONParsingKeys.PosterPath] as? String else {
      throw SerializaionError.missing(Constants.JSONParsingKeys.Popularity)
    }
    self.posterPath = posterPath
      
    guard let originalTitle = dictionary[Constants.JSONParsingKeys.OriginalTitle] as? String else {
      throw SerializaionError.missing(Constants.JSONParsingKeys.OriginalTitle)
    }
    self.originalTitle = originalTitle
    
    guard let releaseDate = dictionary[Constants.JSONParsingKeys.ReleaseDate] as? String else {
      throw SerializaionError.missing(Constants.JSONParsingKeys.ReleaseDate)
    }
    self.releaseDate = releaseDate
    
    guard let voteAverage = dictionary[Constants.JSONParsingKeys.VoteAverage] as? Float else {
      throw SerializaionError.missing(Constants.JSONParsingKeys.VoteAverage)
    }
    self.voteAverage = voteAverage
    
    guard let voteCount = dictionary[Constants.JSONParsingKeys.VoteCount] as?  Int else {
      throw SerializaionError.missing(Constants.JSONParsingKeys.VoteCount)
    }
    self.voteCount = voteCount
    
  }
  
  
}
