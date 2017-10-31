//
//  Constants.swift
//  XMLParsingAndCenteredPaging
//
//  Created by siwook on 2017. 10. 31..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

import UIKit

// MARK: - Constants
struct Constants {

  static let SectionInsets                     = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
  static let ImageIdLablePrefix                = "Image id: "
  static let NumberOfItems: CGFloat            = 2
  static let CellHeight: CGFloat               = 190
  static let CardViewCornerRadius: CGFloat     = 3
  static let CatCellCornerRadius: CGFloat      = 6
  static let SecondsAgo                        = " seconds ago"
  static let MinutesAgo                        = " minutes ago"
  static let HoursAgo                          = " hours ago"
  static let DaysAgo                           = " days ago"
  static let WeeksAgo                          = " weeks ago"
  static let TimeAgoDateFormat                 = "yyyy-MM-dd HH:mm:ss"
  static let TimeAgoDateFormatLocalIdentifier  = "de_DE"
  static let NoFavoriteCatList                 = "There is no favorite cat list"

  // MARK: - Fatal Error
  struct FatalError {
    static let UnExpectedTableViewCell      = "Unexpected Table View Cell"
    static let UnExpectedCollectionViewCell = "Unexpected Collection View Cell"
  }

  // MARK: - Image File Names
  struct ImageFileName {
    static let NoImage        = "ic_noImage"
    static let FavoriteEmpty  = "ic_favorite_empty"
    static let FavoriteFilled = "ic_favorite_filled"
  }

  // MARK: - Cell Identification
  struct CellID {
    static let CatImage         = "catImageCollectionViewCell"
    static let FavoriteCatImage = "favoriteCatImageTableViewCell"
  }

  // MARK: - API
  struct API {

    static let BaseURL = "http://thecatapi.com/api"

    // MARK: - API Method List
    struct Methods {
      static let GetImages     = "/images/get"
      static let GetFavourites = "/images/getfavourites"
      static let FavoriteImage = "/images/favorite"
    }

    // MARK: - URL Query List
    struct QueryItem {
      static let FormatKey           = "format"
      static let FormatValue         = "xml"
      static let ResultsPerPageKey   = "results_per_page"
      static let ResultsPerPageValue = "20"
      static let SubIdKey            = "sub_id"
      static let SubIdValue          = "siwook"
      static let ActionKey           = "action"
      static let ActionValue         = "remove"
      static let APIKey              = "api_key"
      static let APIValue            = "MTkxNzY4"
      static let ImageIdKey          = "image_id"
      static let SizeKey             = "size"
      static let SizeValue           = "small"
    }

    // MARK: - XML Parsing Key List
    struct XMLParsingKeys {
      static let Response  = "response"
      static let Data      = "data"
      static let Url       = "url"
      static let ImageId   = "id"
      static let SubId     = "sub_id"
      static let Created   = "created"
      static let SourceUrl = "source_url"
      static let Images    = "images"
      static let Image     = "image"
      static let ApiError  = "apierror"
      static let Message   = "message"
    }
  }

  // MARK: - Color List
  struct Color {
    static let ThemeBlue = UIColor(colorLiteralRed: 0/255, green: 171/255, blue: 229/255, alpha: 1)
  }

  // MARK: - Serializaion Error Description
  struct SerializaionErrorDesc {
    static let URLMissing         = "CatImageInfo property is missing"
  }
}
