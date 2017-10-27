//
//  AppDelegate.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
// MARK : - AppDelegate: UIResponder, UIApplicationDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK : - Property
  var window: UIWindow?
  var coreDataStack = CoreDataStack(modelName: Constants.CoreDataModelName)
  var favoriteRestaurantList = [FavoriteRestaurant]()

  // MARK : - Delegate Methods
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    loadFavoriteRestaurantList()
    passContextAndFetchResultToViewController()
    return true
  }

  private func passContextAndFetchResultToViewController() {
    guard coreDataStack != nil else {
      return
    }
    guard let navController = window?.rootViewController as? UINavigationController,
      let viewController = navController.topViewController as? RestaurantListViewController else {
        return
    }
    viewController.managedContext = coreDataStack!.context
    viewController.favoriteRestaurantList = favoriteRestaurantList
  }

  private func loadFavoriteRestaurantList() {
    let favoriteRestaurantFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataModelName)
    do {
      guard let fetchedList =  try coreDataStack?.context.fetch(favoriteRestaurantFetchRequest)
        as? [FavoriteRestaurant] else {
        return
      }
      favoriteRestaurantList = fetchedList
    } catch let error as NSError {
      print("Could not fetch \(error.userInfo),\(error.localizedDescription)")
    }
  }

  func applicationWillTerminate(_ application: UIApplication) {
    coreDataStack?.saveContext()
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    coreDataStack?.saveContext()
  }
}
