//
//  AppDelegate.swift
//  SegmentedControl
//
//  Created by siwook on 2017. 7. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var genreList = [Genre]()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let workGroup = DispatchGroup()
    
    RestClient.sharedInstance.requestGenresList { (results, error) in
      
      if let error = error {
        print(error.localizedDescription)
      } else {
        
        guard let jsonResults = results else {
          return
        }
        
        guard let genreInfoArray = jsonResults[Constants.JSONParsingKeys.Genres]  as? [[String:Any]] else {
          return
        }
        
        self.genreList = genreInfoArray.flatMap({ dict -> Genre? in
          do {
            return try Genre(dictionary: dict)
          } catch let error {
            print(error.localizedDescription)
            return nil
          }
        })
        
        for i in 0..<self.genreList.count {
          
          workGroup.enter()
          
          RestClient.sharedInstance.requestGenreMovieList(page: 1, genreId: self.genreList[i].id, completionHandler: { (results, error) in
            
            if let jsonResults = results {
              
              if let dictArray = jsonResults[Constants.JSONParsingKeys.Results] as? [[String:Any]] {
                
                let index = Int(arc4random_uniform(UInt32(self.genreList.count)))
                if let posterPath = dictArray[index][Constants.JSONParsingKeys.PosterPath] as? String {
                  self.genreList[i].setPosterPath(newValue: posterPath)
                }
            
                workGroup.leave()
              }
            }
            
          })
          
        }
        
        workGroup.notify(queue: DispatchQueue.main) {
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationName.Genre), object: nil)
        }
        
      }
      
    }
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

