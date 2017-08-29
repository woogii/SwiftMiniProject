//
//  PullToRefreshClient.swift
//  Project08_PullToRefresh
//
//  Created by siwook on 2017. 8. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation


// MARK : - PullToRefreshClient 

class PullToRefreshClient {

  // MARK : - Properties
  
  static let sharedInstance = PullToRefreshClient()
  var sharedSession : URLSession {
    return URLSession.shared
  }
 
  
  // MARK : - Set API Parameters
  
  func setParameters()->[String:String]{
    return [
      Constants.FlickrParameterKeys.Method  : Constants.FlickrParameterValues.RecentPhotosMethod,
      Constants.FlickrParameterKeys.APIKey  : Secret.APIKey,
      Constants.FlickrParameterKeys.Extras  : Constants.FlickrParameterValues.MediumURL,
      Constants.FlickrParameterKeys.Format  : Constants.FlickrParameterValues.ResponseFormat,
      Constants.FlickrParameterKeys.PerPage : Constants.FlickrParameterValues.NumberOfItems,
      Constants.FlickrParameterKeys.Page    : String(ViewController.page),
      Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
    ]
  }
  
  // MARK: Make Network Request
  
  private func requestImageList(isRefreshing:Bool) {
    
    let methodParameters = setParameters()
    
    let escapedParameters = Helper.escapedParameters(methodParameters as [String : AnyObject])
    let urlString = Constants.Flickr.APIBaseURL + escapedParameters
    
    print("page : \(ViewController.page)")
    print("escaped parameters : \(escapedParameters)")
    let url = URL(string: urlString)!
    let request = URLRequest(url: url)
    
    let task = sharedSession.dataTask(with: request) { (data, response, error) in
      
      // if an error occurs, print it and re-enable the UI
      func displayError(_ error: String) {
        print(error)
        print("URL at time of error: \(url)")
      }
      
      guard (error == nil) else {
        displayError("There was an error with your request: \(error!.localizedDescription)")
        return
      }
      
      guard let data = data else {
        displayError("No data was returned by the request!")
        return
      }
      
           
    }
    task.resume()
  }

}
