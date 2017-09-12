//
//  Genre.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 8. 2..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Genre

struct Genre {
  // MARK : - Property

  var genreId: Int
  var name: String
  var posterPath: String = ""
  typealias GenreInfoQuery = (_ genreList: [Genre]?, _ error: Error?) -> Void

  // MARK : - Initialization

  init(dictionary: [String:Any]) throws {

    guard let id = dictionary[Constants.JSONParsingKeys.IdKey] as? Int else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.IdMissing)
    }
    guard let name = dictionary[Constants.JSONParsingKeys.Name] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.NameMissing)
    }

    self.genreId = id
    self.name = name
  }
  // MARK : - Set Poster URL Path

  mutating func setPosterPath(newValue: String) {
    posterPath = newValue
  }

  static func genres(completionHandler:@escaping GenreInfoQuery) {

    RestClient.sharedInstance.requestGenresList { (results, error) in
      guard error == nil else {
        completionHandler(nil, error)
        return
      }
      guard let wrappedResults = results,
        let genreDictArray = wrappedResults[Constants.JSONParsingKeys.Genres] as? [[String:Any]] else {
        return
      }
      let genreList = genreDictArray.flatMap({ (genreDict) -> Genre? in

        do {
          return try Genre(dictionary: genreDict)
        } catch let error {
          print(error.localizedDescription)
          return nil
        }
      })
      completionHandler(genreList, nil)
    }
  }
}
