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

struct UserInfo {

  // MARK : - Property 
  
  var email:String
  var uid:String
  
  // MARK : - Initialization
  
  init(uid:String, email:String) {
    self.uid = uid
    self.email = email
  }
  
  init(user:User) {
    
    self.uid = user.uid
    self.email = user.email!
  }
  
}
