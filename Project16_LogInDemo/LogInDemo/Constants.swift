//
//  Constants.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constants
struct Constants {

  static let PasswordLimitCount = 15

  // MARK : - Color
  struct Color {
    static let BgGradientLightColor = UIColor(colorLiteralRed: 2/255, green: 124/255, blue: 136/255, alpha: 1.0)
    static let BgGradientDarkColor = UIColor(colorLiteralRed: 4/255, green: 162/255, blue: 151/255, alpha: 1.0)
  }
  // MARK : - Title
  struct Title {
    static let Okay = "Ok"
    static let Cancel = "Cancel"
  }
  // MARK : - DataSnapshot Key
  struct DataSnapshotKey {
    static let Author = "author"
    static let Title  = "title"
    static let Publisher = "publisher"
  }
  // MARK : - Message
  struct Message {
    static let LogInSuccess = "Log In Success"
  }
  // MARK : - Segue ID
  struct SegueID {
    static let ShowUserListVC = "showUserListVC"
    static let ShowBookListVC = "showBookListVC"
  }
  // MARK : - Facebook API
  struct FacebookAPI {
    struct Permission {
      static let PublicProfile = "public_profile"
      static let Email = "email"
    }
  }

}
