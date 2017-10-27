//
//  FavoriteRestaurant+CoreDataProperties.swift
//  
//
//  Created by siwook on 2017. 9. 21..
//
//

import Foundation
import CoreData

// MARK : - FavoriteRestaurant (Extension)
extension FavoriteRestaurant {
    // MARK : - Fetch Request
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRestaurant> {
        return NSFetchRequest<FavoriteRestaurant>(entityName: Constants.CoreDataModelName)
    }
    // MARK : - Property
    @NSManaged public var averageProductPrice: Float
    @NSManaged public var bestMatch: Float
    @NSManaged public var deliveryCosts: Int32
    @NSManaged public var distance: Int32
    @NSManaged public var imageName: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var minCost: Int32
    @NSManaged public var name: String?
    @NSManaged public var newest: Float
    @NSManaged public var popularity: Float
    @NSManaged public var ratingAverage: Double
    @NSManaged public var status: String?

}
