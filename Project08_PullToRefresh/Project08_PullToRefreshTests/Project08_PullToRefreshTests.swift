//
//  Project08_PullToRefreshTests.swift
//  Project08_PullToRefreshTests
//
//  Created by siwook on 2017. 4. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
@testable import Project08_PullToRefresh

class Project08_PullToRefreshTests: XCTestCase {
  
  var controllerUnderTest:ViewController!
  
  override func setUp() {
    super.setUp()
    controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vc") as? ViewController
  }
  
  override func tearDown() {
    controllerUnderTest = nil
    super.tearDown()
  }
  
  func testFlickrGetRecentAPICall() {
    
    let methodParameters = [
      Constants.FlickrParameterKeys.Method  : Constants.FlickrParameterValues.RecentPhotosMethod,
      Constants.FlickrParameterKeys.APIKey  : Secret.APIKey,
      Constants.FlickrParameterKeys.Extras  : Constants.FlickrParameterValues.MediumURL,
      Constants.FlickrParameterKeys.Format  : Constants.FlickrParameterValues.ResponseFormat,
      Constants.FlickrParameterKeys.PerPage : Constants.FlickrParameterValues.NumberOfItems,
      Constants.FlickrParameterKeys.Page    : Constants.FlickrParameterValues.InitialPage,
      Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
    ]

    let urlString = Constants.Flickr.APIBaseURL + Helper.escapedParameters(methodParameters as [String : AnyObject])
    let url = URL(string: urlString)!
    let request = URLRequest(url: url)
    let promise = expectation(description: "Status code : 200")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

      if let error = error {
        XCTFail("Error : \(error.localizedDescription)")
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        if statusCode == 200 {
          promise.fulfill()
        } else {
          XCTFail("Status code : \(statusCode)")
        }
      }
    }
    
    task.resume()
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
