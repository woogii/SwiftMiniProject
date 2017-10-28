//
//  Place.swift
//  StickyHeaderViewDemo
//
//  Created by siwook on 2017. 4. 2..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
import MapKit

// MARK : - Place: NSObject, MKAnnotation 

class Place: NSObject, MKAnnotation {

  // MARK : - Property 
  
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D
  
  // MARK : - Initialization 
  
  init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
    
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    
    super.init()
  }
  
  
}
