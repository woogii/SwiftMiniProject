//
//  CoreDataStack.swift
//  CoolNotes
//
//  Created by siwook on 2017. 5. 14..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import CoreData

// MARK : - CoreDataStack 

struct CoreDataStack {
  private let model: NSManagedObjectModel
  let coordinator: NSPersistentStoreCoordinator
  private let modelURL: URL
  let dbURL: URL
  let context: NSManagedObjectContext
  init?(modelName: String) {
    guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
      print("Unable to find \(modelName) in the main bundle")
      return nil
    }
    self.modelURL = modelURL
    // create model from url
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
      print("Unable to create model from \(modelURL)")
      return nil
    }
    self.model = model
    // create the store coordinator
    coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = coordinator
    let fm = FileManager.default
    guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    self.dbURL = docUrl.appendingPathComponent("Project09_ToDoList.sqlite")
    // Options for migration
    let options = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]
    do {
      try addStoreCoordinator(NSSQLiteStoreType, configuration: nil,
                              storeURL: dbURL, options: options as [NSObject : AnyObject]?)
    } catch {
      print("unable to add store at \(dbURL)")
    }

  }
  // MARK: Utils
  func addStoreCoordinator(_ storeType: String, configuration: String?,
                           storeURL: URL, options: [NSObject:AnyObject]?) throws {
    try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: nil)
  }
}
// MARK: - CoreDataStack (Removing Data)
internal extension CoreDataStack {
  func dropAllData() throws {
    // delete all the objects in the db. This won't delete the files, it will
    // just leave empty tables.
    try coordinator.destroyPersistentStore(at: dbURL, ofType:NSSQLiteStoreType, options: nil)
    try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: nil)
  }
}

// MARK: - CoreDataStack (Save Data)
extension CoreDataStack {
  func saveContext() throws {
    if context.hasChanges {
      try context.save()
    }
  }
  func autoSave(_ delayInSeconds: Int) {
    if delayInSeconds > 0 {
      do {
        try saveContext()
        print("Autosaving")
      } catch {
        print("Error while autosaving")
      }
      let delayInNanoSeconds = UInt64(delayInSeconds) * NSEC_PER_SEC
      let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds)) / Double(NSEC_PER_SEC)
      DispatchQueue.main.asyncAfter(deadline: time) {
        self.autoSave(delayInSeconds)
      }
    }
  }
}
