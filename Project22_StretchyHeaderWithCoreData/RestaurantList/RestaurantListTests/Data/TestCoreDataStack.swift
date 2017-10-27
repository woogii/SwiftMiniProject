//
//  TestCoreDataStack.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CoreDataStack

struct TestCoreDataStack {
  // MARK: - Property
  private let model: NSManagedObjectModel
  internal let coordinator: NSPersistentStoreCoordinator
  private let modelURL: URL
  internal let dbURL: URL
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
    // Add in-memory store
    try coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: dbURL, options: nil)
  }
}
