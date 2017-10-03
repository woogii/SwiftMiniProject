//
//  ToDoItem+CoreDataProperties.swift
//  Project09_ToDoList
//
//  Created by siwook on 2017. 5. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import CoreData

extension ToDoItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }
    @NSManaged public var title: String?
}
