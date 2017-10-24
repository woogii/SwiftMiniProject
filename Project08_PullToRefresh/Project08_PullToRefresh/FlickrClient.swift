//
//  FlickrClient.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 10. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - FlickrClient
struct FlickrClient {

  // MARK: - Network Request
  typealias PhotoRequestResult = (_ result: [PhotoInfo]?, _ error: Error?) -> (Void)

  func requestPhotoInfoList(currentPage: Int, completionHandler:@escaping PhotoRequestResult) {

    guard let photoListUrl = buildRequestUrl(currentPage: currentPage) else {
      return
    }

    URLSession.shared.dataTask(with:photoListUrl, completionHandler: { (data, _, error) in

      var photoInfoList: [PhotoInfo] = []

      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
        let jsonDict = json?[Constants.FlickrResponseKeys.Photos] as? [String:Any],
        let photoInfoArray = jsonDict[Constants.FlickrResponseKeys.Photo] as? [[String:Any]] {

        for case let photoItem in photoInfoArray {
          if let photoInfo = try? PhotoInfo(photoInfoDictionary: photoItem) {
            photoInfoList.append(photoInfo)
          }
        }

        completionHandler(photoInfoList, error)
      }

    }).resume()

  }

  func buildRequestUrl(currentPage: Int) -> URL? {

    guard var urlComponent = URLComponents(string: Constants.Flickr.APIBaseURL) else {
      return nil
    }

    urlComponent.queryItems = [
      URLQueryItem(name: Constants.FlickrParameterKeys.Method,
                   value: Constants.FlickrParameterValues.RecentPhotosMethod),
      URLQueryItem(name: Constants.FlickrParameterKeys.APIKey, value: Secret.APIKey),
      URLQueryItem(name: Constants.FlickrParameterKeys.Extras, value: Constants.FlickrParameterValues.MediumURL),
      URLQueryItem(name: Constants.FlickrParameterKeys.Format, value: Constants.FlickrParameterValues.ResponseFormat),
      URLQueryItem(name: Constants.FlickrParameterKeys.PerPage, value: Constants.FlickrParameterValues.NumberOfItems),
      URLQueryItem(name: Constants.FlickrParameterKeys.Page, value: String(currentPage)),
      URLQueryItem(name: Constants.FlickrParameterKeys.NoJSONCallback,
                   value: Constants.FlickrParameterValues.DisableJSONCallback)
    ]

    return urlComponent.url
  }
}
