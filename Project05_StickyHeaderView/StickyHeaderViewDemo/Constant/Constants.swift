//
//  Constants.swift
//  StickyHeaderViewDemo
//
//  Created by siwook on 2017. 9. 6..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants

struct Constants {

  // MARK : - Icon Image Name 
  
  struct IconImageName {
    
    static let Phone = "ic_phone"
    static let Mail = "ic_mail"
    static let Link = "ic_phone"
    
  }
  
  static let RestaurantPhoneNumber = "+82-01-1111-2222"
  static let RestaurantMailAddress = "sample@sample.com"
  static let RestaurantHomePage = "http://wwww.github.com/woogii"
  static let NumberOfRows = 3
  
  // MARK : - Place Annotation Titles
  
  struct PlaceAnnotation {
    static let Title = "Restaurant"
    static let SubTitle = "Brunch"
  }
  
  // MARK : - TableViewCell ID
  
  struct CellID {
    static let CustomCell = "customCell"
  }
  
  // MARK : - Button Titles
  
  struct ButtonTitle {
    static let Cancel = "cancel"
  }
  
  // MARK : - Alert Messages
    
  struct AlertMessage {
    static let FavoriteButtonTapped = "favorite button tapped"
    static let ProfileButtonTapped = "profile button tapped"
    static let BackButtonTapped = "back button tapped"
  }
  
  // MARK : - Adjust Values For Frames
  
  struct AdjustCoordPoint {
    
    static let BgImageViewY:CGFloat = 160
    static let ProfileImageViewY:CGFloat = 22
    static let ProfileImageViewX:CGFloat = 40
    static let ProfileButtonX:CGFloat = 22
    static let ProfileButtonY:CGFloat = 40
    static let FavoriteImageY:CGFloat = 22
    static let BackImageY:CGFloat = 25
    
  }
  
  
}
