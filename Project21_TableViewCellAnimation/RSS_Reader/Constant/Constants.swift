//
//  Constants.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - Constants

struct Constants {

  // MARK: - APIRequest

  struct APIRequest {

    static let BaseUrl      = "https://api.rss2json.com/v1/api.json?rss_url="
    static let MoviesUrl    = "http://www.movies.com/rss-feeds/movie-news-rss"
    static let CelebrityUrl = "http://www.popsugar.com/entertainment/feed"
    static let GeneralUrl   = "http://feeds.feedburner.com/variety/headlines"

    // MARK: - UrlQuery
    struct UrlQuery {
      static let Source = "source"
      static let SortBy = "sortBy"
      static let ApiKey = "apiKey"
    }
  }

  // MARK: - JSONResponseKeys

  struct JSONResponseKeys {
    static let Items       = "items"
    static let Author      = "author"
    static let Title       = "title"
    static let PublishDate = "pubDate"
    static let Link        = "link"
    static let Description = "description"
    static let Url         = "url"
    static let Thumbnail   = "thumbnail"
    static let Enclosure   = "enclosure"
  }

  // MARK: - Cell Identifiers
  struct CellID {
    static let News = "newsCell"
  }

  // MARK: - NewsSource
  struct NewsSource {
    static let TechCrunch = "techcrunch"
    static let TechRadar = "techRadar"
    static let Recode = "recode"
  }

  // MARK: - Serializaion Error Description
  struct SerializaionErrorDesc {
    static let TitleMissing          = "Title is missing"
    static let PublishedDateMissing  = "Published date is missing"
    static let UrlLinkMissing        = "Url Link is missing"
    static let ThumbnailMissing      = "Thumbnail is missing"
  }

  static let NewsFeedDateFormat = "yyyy-MM-dd HH:mm:ss"
}
