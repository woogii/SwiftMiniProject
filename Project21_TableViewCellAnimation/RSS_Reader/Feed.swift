//
//  Feed.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 10. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - SerializationError
enum SerializationError: Error {
  case missing(String)
  case invalid(String, Any)
}

// MARK: - Feed
struct Feed {

  // MARK: - Property List
  var title: String
  var pubDate: Date
  var urlLink: String
  var thumbnail: String

  // MARK: - Initialization
  init(dictionary: [String: Any]) throws {
    guard let title = dictionary[Constants.JSONResponseKeys.Title] as? String else {
      throw SerializationError.missing(Constants.SerializaionErrorDesc.TitleMissing)
    }
    guard let pubDate = dictionary[Constants.JSONResponseKeys.PublishDate] as? String else {
      throw SerializationError.missing(Constants.SerializaionErrorDesc.PublishedDateMissing)
    }
    guard let urlLink = dictionary[Constants.JSONResponseKeys.Link] as? String else {
      throw SerializationError.missing(Constants.SerializaionErrorDesc.UrlLinkMissing)
    }
    guard let thumbnail = dictionary[Constants.JSONResponseKeys.Thumbnail] as? String else {
      throw SerializationError.missing(Constants.JSONResponseKeys.Thumbnail)
    }
    self.title     = title
    self.pubDate   = Feed.createPublishedDate(pubDate: pubDate)
    self.urlLink   = urlLink
    self.thumbnail = thumbnail
  }

  static func createPublishedDate(pubDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.NewsFeedDateFormat
    return dateFormatter.date(from: pubDate) ?? Date()
  }
}

extension Feed: CustomStringConvertible {
  var description: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.NewsFeedDateFormat
    let contents = "Title: \(self.title)\n" + "date: \(dateFormatter.string(from: self.pubDate))\n"
                   + "Link : \(self.urlLink)\n" + "ThumbNail : \(self.thumbnail)\n"
    return contents
  }
}
