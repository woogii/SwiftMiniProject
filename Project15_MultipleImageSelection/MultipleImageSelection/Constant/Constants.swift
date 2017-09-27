//
//  Constants.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Constants
struct Constants {
  // MARK : - Alert Title
  struct AlertTitle {
    static let Confirm = "Confirm"
    static let Cancel = "Cancel"
    static let PhotoLibrary = "Choose from library"
    static let TakePhoto = "Take Profile Photo"
  }
  // MARK : - Alert Message
  struct AlertMessage {
    static let MaximumImageCountReached = "Cannot select more than five images"
  }

  static let MaxImageCount = 5
  // MARK : - Cell Identifier
  struct CellID {
    static let ProfileInfo = "profileInfoCell"
    static let ProfileImage = "profileImageCell"
  }

}
