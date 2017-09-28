//
//  MindvalleyImage.swift
//  Mindvalley application
//
//  Created by siwook on 2017. 4. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - RestClient
open class RestClient: NSObject {
  // MARK : - Property
  typealias CompletionHandler = (_ result: AnyObject?, _ error: Error?) -> Void
  open static let sharedInstance = RestClient()
  open static let dataCache = NSCache<NSString, DiscardableImageContent>()
  private var session: URLSession!
  // MARK : - Initialization
  override init() {
    session = URLSession.shared
    super.init()
  }
  // MARK: - Requesting Data
  func taskForGetData(urlString: String,
                      parameters: [String : AnyObject]?=nil,
                      size: Int?=nil,
                      completionHandler: @escaping CompletionHandler) -> URLSessionDataTask? {
    guard let url = URL(string:urlString) else {
      return nil
    }
    let request = URLRequest(url: url)
    // Code that configure header fields can be written here
    let task = URLSession.shared.dataTask(with: request) { (data, response, downloadError) in
      if let error = downloadError {
        let customizedError = RestClient.errorForData(data: data, response:response, error:error)
        completionHandler(nil, customizedError)
      } else {
        RestClient.parseJSONWithCompletionHandler(data: data!, completionHandler: completionHandler)
      }
    }
    task.resume()
    return task
  }
  // MARK: - Requesting Image
  func taskForGetImageWith(urlString: String,
                           parameters: [String : AnyObject]?=nil,
                           size: Int?=nil,
                           completionHandler: @escaping CompletionHandler) -> URLSessionDataTask? {
    guard let url = URL(string:urlString) else {
      return nil
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, downloadError) in
      if let error = downloadError {
        let customizedError = RestClient.errorForData(data: data, response:response, error:error)
        completionHandler(nil, customizedError)
      } else {
        completionHandler(data as AnyObject?, nil)
      }
    }
    task.resume()
    return task
  }
  // MARK: - Error response handling
  class func errorForData(data: Data?, response: URLResponse?, error: Error) -> Error {
    if data == nil {
      return error
    }
    do {
      let parsedResult = try JSONSerialization
                              .jsonObject(with: data!,
                                          options: JSONSerialization.ReadingOptions.allowFragments)
      if let parsedResult = parsedResult as? [String : AnyObject],
        let errorCode = parsedResult[Constants.JSONResponseKeys.ErrorInfo.Code] as? String {
        let errorMessage = parsedResult[errorCode]
        let userInfo = [NSLocalizedDescriptionKey: errorMessage as Any]
        return NSError(domain: Constants.JSONResponseKeys.ErrorInfo.Domain,
                       code:Int(errorCode)!, userInfo: userInfo) as Error
      }
    } catch _ {}
    return error
  }
  // MARK : - Parsing the JSON
  class func parseJSONWithCompletionHandler(data: Data,
                                            completionHandler: CompletionHandler) {
    var parsingError: Error?
    var parsedResult: Any?
    do {
      parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    } catch let error as NSError {
      parsingError = error
    }
    if let error = parsingError {
      completionHandler(nil, error)
    } else {
      completionHandler(parsedResult as AnyObject?, nil)
    }
  }
  // MARK : - Percent encoding URL strings
  class func escapedParameters(parameters: [String : AnyObject]) -> String {
    var urlVars = [String]()
    for (key, value) in parameters {
      let stringValue = "\(value)"
      let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      if let unwrappedEscapedValue = escapedValue {
        urlVars += [key + "=" + "\(unwrappedEscapedValue)"]
      } else {
        #if DEBUG
          print("Warning: trouble escaping string \"\(stringValue)\"")
        #endif
      }
    }
    return (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator: "&")
  }
  // MARK: - Shared Image Cache
  struct Caches {
    static let imageCache = CustomCache()
  }
}
