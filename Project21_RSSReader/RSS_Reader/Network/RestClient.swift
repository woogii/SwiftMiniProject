//
//  RestClient.swift
//  RSS_Reader
//
//  Created by siwook on 2017. 8. 26..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - RestClient

struct RestClient {

  // MARK : - Property

  var sharedSession = URLSession.shared
  static let sharedInstance = RestClient()
  typealias NewListRequestResult = (_ result: [Feed]?, _ error: Error?) -> Void

	// MARK : - Request News List

  func requestNews(with sourceString: String, completionHandler:@escaping NewListRequestResult) {
    print(sourceString)
    // guard let url = buildUrlWithQueryItems(newsSource) else { return }
    guard let url = URL(string: sourceString) else { return }

    URLSession.shared.dataTask(with: url) {data, response, error in

      guard error == nil else {
        print(error!.localizedDescription)
        return
      }

      guard let data = data, let response = response as? HTTPURLResponse,
       200..<300 ~= response.statusCode else {
        return
      }

      do {
        let serializedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let json = serializedResult as? [String:Any],
                let dictArray = json["items"] as? [[String:Any]] else {
          return
        }
        var feedList = [Feed]()
        for dict in dictArray {
          do {
            let feed = try Feed(dictionary: dict)
            feedList.append(feed)
          } catch let error as NSError {
            print(error.localizedDescription)
          }
        }
        completionHandler(feedList, error)

      } catch let error as NSError {
          print("Cannot parse \(error.userInfo), \(error.localizedDescription)")
      }

    }.resume()

  }

  func buildUrlWithQueryItems(_ newsSource: String) -> URL? {

    guard var urlComponents = URLComponents(string: Constants.APIRequest.BaseUrl) else {
      return nil
    }

    let sourceQuery = URLQueryItem(name: "source", value: newsSource)
    let sortQuery = URLQueryItem(name: "sortBy", value: "top")
    let apiKeyQuery = URLQueryItem(name: "apiKey", value: apiKey)

    urlComponents.queryItems = [sourceQuery, sortQuery, apiKeyQuery]

    guard let url = urlComponents.url else { return nil }
    return url
  }

}
