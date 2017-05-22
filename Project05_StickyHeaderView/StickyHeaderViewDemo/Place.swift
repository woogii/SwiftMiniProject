//
//  Place.swift
//  StickyHeaderViewDemo
//
//  Created by siwook on 2017. 4. 2..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
  
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
    
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    
    super.init()
  }
  
  
}
