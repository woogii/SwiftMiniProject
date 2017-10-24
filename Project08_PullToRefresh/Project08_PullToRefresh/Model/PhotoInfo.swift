//
//  PhotoInfo.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 4. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - PhotoInfo

struct PhotoInfo {

  // MARK: - Property

  var title: String
  var mediumUrl: String
  var idKey: String
  var numberOfLikes: Int
  var registeredDate: Date

  enum SerializationError: Error {
    case missing(String)
  }

  // MARK: - Initialization

  init(photoInfoDictionary: [String:Any]) throws {

    guard let title = photoInfoDictionary[Constants.FlickrResponseKeys.Title] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.TitleMissing)
    }

    guard let mediumUrl = photoInfoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.URLMissing)
    }

    guard let id = photoInfoDictionary[Constants.FlickrResponseKeys.IDKey] as? String else {
      throw SerializationError.missing(Constants.SerializationErrorDesc.IdMissing)
    }

    let numberOfLikes = Int(arc4random_uniform(UInt32(photoInfoDictionary.count)))
    let timeInterval = Int(arc4random_uniform(UInt32(3600*24))) * -1
    let date = Date(timeIntervalSinceNow: (Double)(timeInterval))

    self.title = title
    self.mediumUrl = mediumUrl
    self.idKey = id
    self.numberOfLikes = numberOfLikes
    self.registeredDate = date
  }
}
