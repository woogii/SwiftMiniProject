//
//  PostInformation.swift
//  RedditClone
//
//  Created by siwook on 2017. 4. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - PostInformation 

struct PostInformation {

  // MARK : - Property 

  var title: String
  var postImage: UIImage
  var upvoteCount: Int
  var postingDate: Date
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateFormatter
  }()

  // MARK : - Initialization

  init(dictionary: [String:Any]) {

    self.title = dictionary[Constants.JSONResponseKeys.Title] as? String ?? ""
    self.upvoteCount = dictionary[Constants.JSONResponseKeys.UpvoteCount] as? Int ?? 0

    if let postImageName = dictionary[Constants.JSONResponseKeys.PostImageName] as? String {
      self.postImage = UIImage(named:postImageName)!
    } else {
      self.postImage = UIImage(named:Constants.ImageName.Default)!
    }

    if let dateString = dictionary[Constants.JSONResponseKeys.PostingDate] as? String {
      self.postingDate = dateFormatter.date(from: dateString) ?? Date()
    } else {
      self.postingDate = Date.distantFuture
    }

  }

}
