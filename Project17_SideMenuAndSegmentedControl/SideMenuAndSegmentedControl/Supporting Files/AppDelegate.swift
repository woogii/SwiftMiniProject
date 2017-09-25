//
//  AppDelegate.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 6. 29..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let storyboard = UIStoryboard(name: Constants.StorybordName.Main, bundle: nil)
    guard let navigationController = storyboard.instantiateViewController(
      withIdentifier: Constants.StoryboardID.NavigationController) as? UINavigationController else {
      return false
    }

    navigationController.setViewControllers([storyboard.instantiateViewController(
      withIdentifier: Constants.StoryboardID.BookListVC)], animated: false)

    guard let mainViewController = storyboard.instantiateInitialViewController() as? MainViewController else {
      return false
    }
    mainViewController.rootViewController = navigationController

    let window = UIApplication.shared.delegate!.window!!
    window.rootViewController = mainViewController

    return true
  }

}
