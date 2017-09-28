//
//  Mindvalley_applicationTests.swift
//  Mindvalley applicationTests
//
//  Created by siwook on 2017. 4. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
@testable import PinterestStyleList
class PinterestStyleListapplicationTests: XCTestCase {
  var controllerUnderTest: ImageListViewController!
  var bundleDataUnderTest: Data!
  var sessionUnderTest: URLSession!
  var postInfoUnderTest: [PostInfo]!
  override func setUp() {
    super.setUp()
    createTestViewController()
    createTestBundleData()
    createTestUrlSession()
  }
  func createTestViewController() {
    guard let controller = UIStoryboard(name: "Main",
                                       bundle: nil)
      .instantiateViewController(withIdentifier: "ImageListVC") as? ImageListViewController else {
        return
    }
    controllerUnderTest = controller
  }
  func createTestBundleData() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "sampleData", ofType: "json")
    bundleDataUnderTest = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
  }
  func createTestUrlSession() {
    sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
  }
  override func tearDown() {
    clearTestVariables()
    super.tearDown()
  }
  func clearTestVariables() {
    controllerUnderTest = nil
    bundleDataUnderTest = nil
    sessionUnderTest = nil
    postInfoUnderTest = nil
  }
  func testLoadDataFromBundle() {
    controllerUnderTest.loadDataFromBundle()
    XCTAssertEqual(controllerUnderTest?.posts.count, 10, "couldn't fetch 10 items")
  }
  func testDataParsingAfterLoadingDataFromBundle() {
    do {
      let dictionaryArray = try(JSONSerialization.jsonObject(with: bundleDataUnderTest!,
                                                             options: .allowFragments)) as? [[String: Any]]
      postInfoUnderTest = dictionaryArray?.flatMap(PostInfo.init)
      XCTAssertEqual(postInfoUnderTest.count, 10, "couldn't parse 10 items from bundle")
    } catch _ {}
  }
  func testImageRequestWithUrlString() {
    do {
      let dictionaryArray = try(JSONSerialization.jsonObject(with: bundleDataUnderTest!,
                                                             options: .allowFragments)) as? [[String: Any]]
      postInfoUnderTest = dictionaryArray?.flatMap(PostInfo.init)
    } catch _ {}
    let url = URL(string: postInfoUnderTest[0].backgroundImageUrlString!)
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?
    let dataTask = sessionUnderTest.dataTask(with: url!) { _, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }
}
