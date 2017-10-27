//
//  RestaurantTest.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
@testable import RestaurantList

// MARK : - RestaurantTest: XCTestCase
class RestaurantTest: XCTestCase {
  // MARK : - Test Property
  var restaurantList: [Restaurant]!
  // MARK : - Set Up
  override func setUp() {
    super.setUp()
    testFetchRestaurantInfo()
  }
  // MARK : - Tear Down
  override func tearDown() {
    super.tearDown()
    restaurantList = []
  }
  // MARK : - Test Restaurant Information Fetching 
  func testFetchRestaurantInfo() {
    restaurantList = Restaurant.fetchRestaurantList(fileName: Constants.SampleResource.TestFileName,
                                     bundle: Bundle(for:RestaurantListTests.self))
    XCTAssertEqual(restaurantList.count, 19, "couldn't fetch 19 items from bundle")
  }
  func testFirstFetchedRestaurantHasExpectedValues() {
    verifyFetchedRestaurantListHasExpectedValues(index:0)
  }
  func verifyFetchedRestaurantListHasExpectedValues(index: Int) {
    let restaurant = restaurantList[index]
    XCTAssertEqual(restaurant.name, "Tanoshii Sushi")
    XCTAssertEqual(restaurant.status, "open")
    XCTAssertEqual(restaurant.bestMatch, 0.0)
  }
  func testSortListByOptions() {
    let option = Constants.SortOption.Popularity
    verifySotedRestaurantListHasExpectedValues(sortOptions:option)
  }
  func verifySotedRestaurantListHasExpectedValues(sortOptions: String) {
    restaurantList = Restaurant.sortListByOptions(restaurantList: restaurantList, selectedSortOption: sortOptions)
    for res in restaurantList {
      print("name : \(res.name)    popularity : \(res.popularity)")
    }
    XCTAssertEqual(restaurantList[0].name, "Roti Shop")
    XCTAssertEqual(restaurantList[0].status, "open")
    XCTAssertEqual(restaurantList[0].popularity, 81.0)
  }
}
