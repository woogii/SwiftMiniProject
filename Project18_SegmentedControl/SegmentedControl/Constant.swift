//
//  Constant.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants 

struct Constants {

  // MARK : - API 
  
  struct API {
    
    static let BaseUrl = "https://api.themoviedb.org"
    static let Path = "/3"
    static let BaseImageUrl = "https://image.tmdb.org/t/p"
    static let PosterImageSize = "/w342"
    static let StringTrue = "true"
    static let StringFalse = "false"
    
    struct ParameterKeys {
      static let Method = "method"
      static let ApiKey = "api_key"
      static let ListId = "list_id"
      static let Page = "page"
      static let SortBy = "sort_by"
      static let IncludeAdult = "include_adult"
      static let IncludeVideo = "include_video"
      static let WithGenres = "with_genres"
    }
    
    struct ParameterValues {
      static let PopularityDesc = "popularity.desc"
    }
    
    struct Methods {
      
      static let DiscoverMovie = "/discover/movie"
      static let Configuration = "/configuration"
      static let List = "/list"
      static let MovieNowPlaying = "/movie/now_playing"
      static let MovieUpcoming = "/movie/upcoming"
      static let GenreList = "/genre/movie/list"
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
    static let Id            = "id"
    static let Name          = "name"
    static let Genres        = "genres"
    
  }
  
  // MARK : - Cell ID
  
  struct CellID {
    
    struct CollectionView {
      static let DiscoveredMovie = "discoveredMovieCollectionViewCell"
      static let InTheatersMovie = "inTheatersMovieCollectionViewCell"
      static let Genre = "genreCollectionViewCell"
    }
  }
  
  struct CellConfiguration {
    
    static let SectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0.0)
    static let NumberOfColumnsForUpcomingCV:CGFloat = 3
    static let MinimumSpacingForUpcomingCell:CGFloat = 3
    static let DiscoverMovieCellHeight:CGFloat = 140
    static let UpcomingMovieCellHeight:CGFloat = 160
    
  }
  // MARK : - Notification Name 
  
  struct NotificationName {
    static let Genre = "genre"
  }
  
  // MARK : - Serializaion Error Description
  
  struct SerializaionErrorDesc {
    
    static let OverviewMissing = "Overview is missing"
    static let PopularityMissing = "Popularity value is missing"
    static let PosterPathMissing = "Poster path is missing"
    static let OriginalTitleMissing = "Original title is missing"
    static let ReleaseDateMissing = "Release date is missing"
    static let VoteAverageMissing = "Vote average value is missing"
    static let VoteCountMissing = "Vote count is missing"
    static let IdMissing = "ID is missing"
    static let NameMissing = "Name is missing"
    static let VoteAverageInvalid = "Voting average value is invalid"
    
  }
  
}
