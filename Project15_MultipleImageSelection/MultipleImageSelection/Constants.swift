//
//  Constants.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

struct Constants {
  
  struct AlertTitle {
    static let Confirm = "Confirm"
    static let Cancel = "Cancel"
    static let PhotoLibrary = "Choose from library"
    static let TakePhoto = "Take Profile Photo"
  }
  
  struct AlertMessage {
    static let MaximumImageCountReached = "Cannot select more than five images"
  }
  
  static let MaxImageCount = 5
  
  struct CellID {
    static let ProfileInfo = "profileInfoCell"
    static let ProfileImage = "profileImageCell"
  }
  
}
