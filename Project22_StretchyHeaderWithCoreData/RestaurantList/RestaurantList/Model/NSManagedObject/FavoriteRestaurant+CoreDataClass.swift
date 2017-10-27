//
//  FavoriteRestaurant+CoreDataClass.swift
//  
//
//  Created by siwook on 2017. 9. 21..
//
//

import Foundation
import CoreData

@objc(FavoriteRestaurant)
// MARK : - FavoriteRestaurant: NSManagedObject 
public class FavoriteRestaurant: NSManagedObject {

  // MARK : - Update Database Based on the Fetch Result
  class func findRestaurantAndUpdate(matching restaurantInfo: Restaurant, in managedContext: NSManagedObjectContext) {
    // suppose that 'name' field is unique
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: Constants.CoreDataModelName)
    fetchRequest.predicate = NSPredicate(format: Constants.NameSearchPredicate, restaurantInfo.name)
    do {
      guard let matches = try managedContext.fetch(fetchRequest) as? [FavoriteRestaurant] else {
        return
      }
      if matches.count > 0 {
        assert(matches.count == 1, Constants.AssertDataInconsistency)
        let matchingRestaurant = matches[0]
        FavoriteRestaurant.deleteFavoriteRestaurant(matching: matchingRestaurant, in: managedContext)
      } else {
        FavoriteRestaurant.insertFavoriteRestaurant(matching: restaurantInfo, in: managedContext)
      }
    } catch let error as NSError {
      print("Fetch request error : \(error.userInfo),\(error.localizedDescription)")
    }
  }
  // MARK : - Insert Favorite Restaurant
  class func insertFavoriteRestaurant(matching restaurantInfo: Restaurant, in managedContext: NSManagedObjectContext) {
    guard let entity = NSEntityDescription.entity(forEntityName: Constants.CoreDataModelName,
                                                  in: managedContext) else {
      return
    }
    let newFavoriteRestaurant = FavoriteRestaurant(entity: entity, insertInto: managedContext)
    newFavoriteRestaurant.name                = restaurantInfo.name
    newFavoriteRestaurant.status              = restaurantInfo.status
    newFavoriteRestaurant.bestMatch           = restaurantInfo.bestMatch
    newFavoriteRestaurant.newest              = restaurantInfo.newest
    newFavoriteRestaurant.ratingAverage       = restaurantInfo.ratingAverage
    newFavoriteRestaurant.distance            = Int32(restaurantInfo.distance)
    newFavoriteRestaurant.popularity          = restaurantInfo.popularity
    newFavoriteRestaurant.averageProductPrice = restaurantInfo.averageProductPrice
    newFavoriteRestaurant.minCost             = Int32(restaurantInfo.minCost)
    newFavoriteRestaurant.imageName           = restaurantInfo.imageName
    newFavoriteRestaurant.isFavorite          = restaurantInfo.isFavorite
    saveChanges(managedContext: managedContext)
  }
  // MARK : - Delete Favorite Restaurant
  class func deleteFavoriteRestaurant(matching restaurantInfo: FavoriteRestaurant,
                                      in managedContext: NSManagedObjectContext) {
    managedContext.delete(restaurantInfo)
    saveChanges(managedContext: managedContext)
  }
  class func saveChanges(managedContext: NSManagedObjectContext) {
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Insert error : \(error.userInfo), \(error.localizedDescription)")
    }
  }
}
