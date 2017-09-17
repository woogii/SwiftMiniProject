//
//  LogInValidator.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 11..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - InputValidator 

class InputValidator {

  // MARK : - Property
  var emailRegExpression: NSRegularExpression!
  var passwordRegExpression: NSRegularExpression!
  let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  let passwordPattern = "^(?=.*[A-Z])(?=.*[!@#$&*]).{6,15}$"

  // MARK : - Initialization
  init() {

    do {
      emailRegExpression = try NSRegularExpression(pattern: emailPattern, options: .caseInsensitive)
      passwordRegExpression = try NSRegularExpression(pattern: passwordPattern, options: [])
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }

  // MARK : - Validate Email 
  func validateEmail(text: String) -> Bool {
    let trimmedText = text.trimmingCharacters(in: .whitespaces)
    return emailRegExpression.firstMatch(in: trimmedText, options: .init(rawValue: 0),
              range: NSRange(location: 0, length: trimmedText.characters.count)) != nil
  }

  // MARK : - Validate Password
  func validatePassword(text: String) -> Bool {
    let trimmedText = text.trimmingCharacters(in: .whitespaces)
    return passwordRegExpression.firstMatch(in: trimmedText,
                                             options: .init(rawValue: 0),
                                             range: NSRange(location: 0, length: trimmedText.characters.count)) != nil
  }
}
