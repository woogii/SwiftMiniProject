//
//  ToDoItem+CoreDataClass.swift
//  Project09_ToDoList
//
//  Created by siwook on 2017. 5. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject {

  convenience init(title:String = "New Item", context: NSManagedObjectContext) {
    
    if let ent = NSEntityDescription.entity(forEntityName: "ToDoItem", in: context) {
      
      self.init(entity: ent, insertInto: context)
      self.title = title

    } else {
      fatalError("Unable to find Entity name!")
    }
  }

  
}
