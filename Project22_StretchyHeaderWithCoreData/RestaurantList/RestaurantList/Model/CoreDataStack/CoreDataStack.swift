//
//  CoreDataStack.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CoreDataStack

struct CoreDataStack {
  // MARK: - Property
  private let model: NSManagedObjectModel
  private let modelURL: URL
  let coordinator: NSPersistentStoreCoordinator
  let dbURL: URL
  let context: NSManagedObjectContext
  // MARK: - Initialization
  init?(modelName: String) {

    guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
      print("Unable to find \(modelName)in the main bundle")
      return nil
    }
    self.modelURL = modelURL
    // Ceate the model from the URL
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
      print("unable to create a model from \(modelURL)")
      return nil
    }
    self.model = model
    // Create the store coordinator
    coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    // Create a context and connect it to the coordinator
    context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = coordinator
    // Add a SQLite store located in the documents folder
    let fm = FileManager.default
    guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      print("Unable to reach the documents folder")
      return nil
    }
    self.dbURL = docUrl.appendingPathComponent("model.sqlite")
    let options = [NSInferMappingModelAutomaticallyOption: true,
                   NSMigratePersistentStoresAutomaticallyOption: true]
    do {
      try addStoreCoordinator(NSSQLiteStoreType, configuration: nil,
                              storeURL: dbURL, options: options as [NSObject : AnyObject]?)
    } catch {
      print("unable to add store at \(dbURL)")
    }
  }
  // MARK: Utils
  func addStoreCoordinator(_ storeType: String, configuration: String?, storeURL: URL,
                           options: [NSObject : AnyObject]?) throws {
    try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: nil)
  }
}

// MARK: - CoreDataStack (Removing Data)
extension CoreDataStack {
  // MARK : - Drop Data
  func dropAllData() {
    // delete all the objects in the db. This won't delete the files, it will
    // just leave empty tables.
    do {
      try coordinator.destroyPersistentStore(at: dbURL, ofType:NSSQLiteStoreType, options: nil)
      try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: nil)
    } catch let error as NSError {
      print("Unresolved error \(error.userInfo), \(error.localizedDescription)")
    }
  }
}

// MARK: - CoreDataStack (Save Data)
extension CoreDataStack {
  // MARK : - Save Data
  func saveContext() {
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch let error as NSError {
      print("Unresolved error \(error.userInfo), \(error.localizedDescription)")
    }
  }
}
