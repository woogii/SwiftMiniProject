//
//  FavoriteRestaurantTest.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
import CoreData
@testable import RestaurantList

// MARK : - FavoriteRestaurantTest: XCTestCase
class FavoriteRestaurantTest: XCTestCase {
  // MARK : - Test Property
  var restaurantList: [Restaurant]!
  var coreDataStack: TestCoreDataStack!
  override func setUp() {
    super.setUp()
    setCoreDataStackForTest()
    setRestaurantList()
  }
  func setCoreDataStackForTest() {
    coreDataStack = TestCoreDataStack(modelName: Constants.CoreDataModelName)!
  }
  func setRestaurantList() {
    restaurantList = Restaurant.fetchRestaurantList(fileName: Constants.SampleResource.TestFileName,
                                                    bundle: Bundle(for:RestaurantListTests.self))
  }
  func testInsertFavoriteRestaurant() {
    FavoriteRestaurant.insertFavoriteRestaurant(matching: restaurantList[0], in: coreDataStack.context)
    guard let insertedRestaurant = fetchFavoriteRestaurantList()?.first else {
      return
    }
    XCTAssertEqual(insertedRestaurant.name, "Tanoshii Sushi")
  }
  func testDeleteFavoriteRestaurant() {
    FavoriteRestaurant.insertFavoriteRestaurant(matching: restaurantList[0], in: coreDataStack.context)
    FavoriteRestaurant.insertFavoriteRestaurant(matching: restaurantList[1], in: coreDataStack.context)
    guard let insertedRestaurant = fetchFavoriteRestaurantList()?.first else {
      return
    }
    FavoriteRestaurant.deleteFavoriteRestaurant(matching: insertedRestaurant, in: coreDataStack.context)
    let fetchResult = fetchFavoriteRestaurantList()
    XCTAssertEqual(fetchResult?.count, 1)
  }
  func fetchFavoriteRestaurantList() -> [FavoriteRestaurant]? {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: Constants.CoreDataModelName)
    do {
      guard let favoriteList = try coreDataStack.context.fetch(fetchRequest)
        as? [FavoriteRestaurant] else {
          return nil
      }
      return favoriteList
    } catch let error as NSError {
      print("Fetch error...\(error.userInfo),\(error.localizedDescription)")
    }
    return nil
  }
  override func tearDown() {
    super.tearDown()
    restaurantList = []
  }
}
