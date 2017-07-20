//
//  Constant.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Constants 

struct Constants {

  // MARK : - API 
  
  struct API {
    
    static let BaseUrl = "https://api.themoviedb.org"
    static let Path = "/3"
    static let BaseImageUrl = "https://image.tmdb.org/t/p"
    static let PosterImageSize = "/w342"
    
    struct ParameterKeys {
      static let Method = "method"
      static let ApiKey = "api_key"
      static let ListId = "list_id"
      static let Page = "page"
      static let SortBy = "sort_by"
      static let IncludeAdult = "include_adult"
      static let IncludeVideo = "include_video"
    }
    
    struct ParameterValues {
      static let PopularityDesc = "popularity.desc"
    }
    
    struct Methods {
      static let DiscoverMovie = "/discover/movie"
      static let Configuration = "/configuration"
      static let List = "/list"
    }
    
    
  }
  
  // MARK : - JSON Parsing Keys
  
  struct JSONParsingKeys {

    static let Results       = "results"
    static let Overview      = "overview"
    static let Popularity    = "popularity"
    static let Title         = "title"
    static let PosterPath    = "poster_path"
    static let OriginalTitle = "original_title"
    static let ReleaseDate   = "release_date"
    static let VoteAverage   = "vote_average"
    static let VoteCount     = "vote_count"
    
  }
  
  // MARK : - Cell ID
  
  struct CellID {
    
    struct CollectionView {
      static let DiscoveredMovie = "discoveredMovieCollectionViewCell"
    }
  }
}
