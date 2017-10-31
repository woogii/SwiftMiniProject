//
//  CatImageInfo.swift
//  XMLParsingAndCenteredPaging
//
//  Created by siwook on 2017. 10. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - SerializaionError : Error
enum SerializaionError: Error {
  case missing(String)
  case invalid(String, Any)
}

// MARK : - CatImageInfo
struct CatImageInfo {

  // MARK : - Property List
  var url: String
  var imageId: String
  var sourceUrl: String

  // MARK : - Initialization
  init(url: String?, imageId: String?, sourceUrl: String?) throws {
    guard let url = url, let imageId = imageId, let sourceUrl = sourceUrl else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.URLMissing)
    }

    self.url        = url
    self.imageId    = imageId
    self.sourceUrl  = sourceUrl
  }
}
