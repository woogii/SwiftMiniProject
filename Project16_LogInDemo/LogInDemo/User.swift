//
//  User.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 11..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import FirebaseAuth

// MARK : - User 

struct User {

  // MARK : - Property 
  
  var email:String
  var uid:String
  
  // MARK : - Initialization
  
  init(uid:String, email:String) {
    self.uid = uid
    self.email = email
  }
  
  init(userInfo:FIRUser) {
    
    self.uid = userInfo.uid
    self.email = userInfo.email!
  }
  
}
