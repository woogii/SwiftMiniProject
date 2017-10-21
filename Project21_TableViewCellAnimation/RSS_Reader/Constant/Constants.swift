//
//  Constants.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Constants

struct Constants {

  // MARK : - APIRequest

  struct APIRequest {

    static let BaseUrl      = "https://api.rss2json.com/v1/api.json?rss_url="
    static let MoviesUrl    = "https://news.ycombinator.com/rss"
    static let CelebrityUrl = "https://news.ycombinator.com/rss"
    static let GeneralUrl   = "https://news.ycombinator.com/rss"

    // MARK : - UrlQuery
    struct UrlQuery {
      static let Source = "source"
      static let SortBy = "sortBy"
      static let ApiKey = "apiKey"
    }
  }

  // MARK : - JSONResponseKeys

  struct JSONResponseKeys {
    static let Author = "author"
    static let Title = "title"
    static let Description = "description"
    static let Url = "url"
    static let UrlToImage = "urlToImage"
    static let PublishedAt = "publishedAt"
  }

  // MARK : - Cell Identifiers
  struct CellID {
    static let NewsCell = "cell"
  }

  // MARK : - NewsSource

  struct NewsSource {
    static let TechCrunch = "techcrunch"
    static let TechRadar = "techRadar"
    static let Recode = "recode"
  }

}
