//
//  Movie.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 19..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Movie (Struct)

struct Movie {
  
  var overview:String
  var popularity:Double      // = "250.123363";
  var posterPath:String      // = "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg"
  var originalTitle: String  //= "Despicable Me 3"
  var releaseDate:String     // "2017-06-29"
  var voteAverage:Float      // "6.2"
  var voteCount:Int          // 543
  
  init?(dictionary:[String:Any]) {
    
    overview = dictionary[Constants.JSONParsingKeys.Overview] as? String ?? ""
    popularity = dictionary[Constants.JSONParsingKeys.Popularity] as? Double ?? 0.0
    posterPath = dictionary[Constants.JSONParsingKeys.PosterPath] as? String ?? ""
    originalTitle = dictionary[Constants.JSONParsingKeys.OriginalTitle] as? String ?? ""
    releaseDate = dictionary[Constants.JSONParsingKeys.ReleaseDate] as? String ?? "" 
    voteAverage = dictionary[Constants.JSONParsingKeys.VoteAverage] as? Float ?? 0.0
    voteCount = dictionary[Constants.JSONParsingKeys.VoteCount] as? Int ?? 0
  }
  
  
}
