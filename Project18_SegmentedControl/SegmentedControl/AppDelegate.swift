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
    
    fetchGenreInformationAndPosterImage()
        return true
  }
  
  // MARK : - Fetch Genre Information with Genre's Poster
  private func fetchGenreInformationAndPosterImage() {
    let workGroup = DispatchGroup()
    
    Genre.genres() { (genresList, error) in
      
      guard error == nil else {
        #if DEBUG
          print(error!.localizedDescription)
        #endif
        return
      }
      
      guard let wrappedGenresList = genresList else {
        return
      }
      
      self.genreList = wrappedGenresList
      
      for i in 0..<self.genreList.count {
        
        workGroup.enter()
        
        Movie.movieListPerGenre(page: 1, genreId: self.genreList[i].id, completionHandler: {
          (genresMovieList, error) in
          
          guard let wrappedGenresMovieList = genresMovieList else {
            return
          }
          
          let index = Int(arc4random_uniform(UInt32(self.genreList.count)))
          let posterPath = wrappedGenresMovieList[index].posterPath
          self.genreList[i].setPosterPath(newValue: posterPath)
          
          workGroup.leave()
        })
      }
      
      workGroup.notify(queue: DispatchQueue.main) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationName.Genre), object: nil)
      }
    }
  }
  
}

