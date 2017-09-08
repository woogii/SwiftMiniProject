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
  typealias NewListRequestResult = (_ result:[String:Any]?, _ error:Error?)->Void
  
	// MARK : - Request News List
 	
  func requestNews(with newsSource:String, completionHandler:@escaping NewListRequestResult) {
  
    
    guard let url = buildUrlWithQueryItems(newsSource) else { return }
    print(url.absoluteURL)
    URLSession.shared.dataTask(with: url) {data,response,error in
     
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      
      guard let data = data, let response = response as?  HTTPURLResponse else {
        return
      }
      
      guard response.statusCode == 200 else {
        print(response.statusCode)
        return
      }
  
      do {
        let serializedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        guard let jsonResult = serializedResult as? [String:Any] else {
          return
        }
        completionHandler(jsonResult, error)
        
      } catch let error as NSError {
          print("Cannot parse \(error.userInfo), \(error.localizedDescription)")
      }
      
    }.resume()
    
  }
  
  func buildUrlWithQueryItems(_ newsSource:String)-> URL? {
    
    guard var urlComponents = URLComponents(string: Constants.APIRequest.BaseUrl) else {
      return nil
    }
    
    let sourceQuery = URLQueryItem(name: "source", value: newsSource)
    let sortQuery = URLQueryItem(name: "sortBy", value: "top")
    let apiKeyQuery = URLQueryItem(name: "apiKey", value: ApiKey)
    
    
    urlComponents.queryItems = [sourceQuery, sortQuery, apiKeyQuery]
    // urlComponents.query = "source=\(newsSource)&sortBy=top&apiKey=\(ApiKey)"

    guard let url = urlComponents.url else { return nil }
    return url
  }
  
}
