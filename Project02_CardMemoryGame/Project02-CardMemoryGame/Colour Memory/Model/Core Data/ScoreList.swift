//
//  ScoreList.swift
//  Colour Memory
//
//  Created by Hyun on 2016. 5. 1..
//  Copyright © 2016년 siwook. All rights reserved.
//

import Foundation
import CoreData

// MARK : - ScoreList : NSManagedObject

class ScoreList: NSManagedObject {

  // MARK : Property

  @NSManaged var name: String
  @NSManaged var score: NSNumber
  @NSManaged var recordTime: Date

  // MARK : Initialization

  override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
    super.init(entity: entity, insertInto: context)
  }

  init(dictionary: [String:AnyObject], context: NSManagedObjectContext?) {

    let entity = NSEntityDescription.entity(forEntityName: Constants.EntityName, in: context!)

    super.init(entity: entity!, insertInto: context)

    guard let name = dictionary[Constants.KeyName] as? String else {
      return
    }
    self.name = name
    guard let score = dictionary[Constants.KeyScore] as? Int else {
      return
    }
    self.score = NSNumber(value : score)
    guard let recordTime  = dictionary[Constants.KeyDate] as? Date else {
      return
    }
    self.recordTime = recordTime
  }
}
