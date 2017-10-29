//
//  AppDelegate.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    FirebaseApp.configure()
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

    FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    let googleHandle =
      GIDSignIn.sharedInstance().handle(url,
                                        sourceApplication: options[.sourceApplication] as? String, annotation: [:])
    let facebookHandle = FBSDKApplicationDelegate.sharedInstance().application(app,
                          open: url,
                          sourceApplication: options[.sourceApplication] as? String,
                          annotation: options[.annotation])
    return googleHandle || facebookHandle
  }

}
