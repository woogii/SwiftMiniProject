//
//  RestaurantListTests.swift
//  RestaurantListTests
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
import CoreData
@testable import RestaurantList

// MARK : - RestaurantListTests: XCTestCase
class RestaurantListTests: XCTestCase {

  var coreDataStack: TestCoreDataStack!
  var controllerUnderTest: RestaurantListViewController!
  var restaurantList: [Restaurant]!

  // MARK : - Set Up
  override func setUp() {
    super.setUp()
    setCoreDataStackForTest()
    setViewControllerForTest()
    setRestaurantList()
  }

  func setCoreDataStackForTest() {
    coreDataStack = TestCoreDataStack(modelName: Constants.CoreDataModelName)!
  }

  func setViewControllerForTest() {
    guard let viewController = UIStoryboard(name: Constants.MainStoryBoard,
                 bundle: nil).instantiateViewController(
                  withIdentifier: Constants.RestaurantVCStoryboardID)
      as? RestaurantListViewController else {
      return
    }
    controllerUnderTest = viewController
    controllerUnderTest.managedContext = coreDataStack.context
  }

  func setRestaurantList() {
    restaurantList = Restaurant.fetchRestaurantList(fileName: Constants.SampleResource.TestFileName,
                                                    bundle: Bundle(for:RestaurantListTests.self))
  }

  // MARK : - Tear Down
  override func tearDown() {
    super.tearDown()
    coreDataStack = nil
    controllerUnderTest = nil
  }
}
