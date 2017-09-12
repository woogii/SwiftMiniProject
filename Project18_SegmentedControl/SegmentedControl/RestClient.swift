//
//  RestClient.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - RestClient 

class RestClient {

  // MARK : - Property

  static let sharedInstance = RestClient()
  typealias CompletionHanlder = (_ result: [String:Any]?, _ error: Error?) -> Void
  var session: URLSession {
    return URLSession.shared
  }

  // MARK : - HTTP Get Request  

  func taskForGetMethod(_ method: String, parameters: [String:Any]?=nil, completionHandler:@escaping CompletionHanlder) {

    let requestUrl = createRequestUrl(method: method, parameters: parameters)

    guard let url = requestUrl else {
      return
    }
    #if DEBUG
      print(url.absoluteString)
    #endif

    session.dataTask(with: url) { (data, _, error) in

      if error != nil {
        #if DEBUG
          print(error?.localizedDescription as Any)
        #endif
        completionHandler(nil, error)

      } else {

        guard let returnData = data else {
          #if DEBUG
            print("data is not returned")
          #endif
          return
        }

        do {

          let jsonObject = try JSONSerialization.jsonObject(with: returnData, options: [])

          guard let jsonResult = jsonObject as? [String:Any] else {
            return
          }

          completionHandler(jsonResult, nil)

        } catch let error {
          print(error.localizedDescription)
        }

      }

    }.resume()

  }

  func createRequestUrl(method: String, parameters: [String:Any]?=nil) -> URL? {

    let baseUrl = Constants.API.BaseUrl + Constants.API.Path + method

    guard var urlComponent = URLComponents(string: baseUrl) else {
      return nil
    }

    guard let wrappedParameters = parameters else {
      return URL(string: baseUrl)
    }

    urlComponent.queryItems = [URLQueryItem]()

    for (key, value) in wrappedParameters {

      let query = URLQueryItem(name: key, value: value as? String)

      urlComponent.queryItems?.append(query)

    }

    return urlComponent.url
  }
}
