//
//  Constants.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

  static let PasswordLimitCount = 15
  
  struct Color {
    
    static let BgGradientLightColor = UIColor(colorLiteralRed: 2/255, green: 124/255, blue: 136/255, alpha: 1.0)
    static let BgGradientDarkColor = UIColor(colorLiteralRed: 4/255, green: 162/255, blue: 151/255, alpha: 1.0)
  }

  struct Title {
    
    static let Ok = "Ok"
    static let Cancel = "Cancel"
    
  }

  struct Message {
    static let LogInSuccess = "Log In Success"
  }
  
  struct SegueID {
    static let ShowUserListVC = "showUserListVC"
  }
  
  struct FacebookAPI {
    
    struct Permission {
      static let PublicProfile = "public_profile"
      static let Email = "email"
    }
  }
  
}
