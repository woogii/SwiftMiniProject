//
//  Book.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 26..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import Firebase

struct Book {
  
  let key:String
  let author : String
  let publisher: String
  let title : String
  let ref : DatabaseReference?
  
  init(key:String, author:String, publisher:String, title:String) {
    
    self.key = key
    self.author = author
    self.publisher = publisher
    self.title = title
    self.ref = nil
  }
  
  init(snapshot:  DataSnapshot) {
    
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String:Any]
    
    author = snapshotValue["author"] as! String
    title = snapshotValue["title"] as! String
    publisher = snapshotValue["publisher"] as! String
    
    self.ref = snapshot.ref
  }

  
  
  func toAnyObject()-> Any {
    return ["author"   : author,
            "publisher": publisher,
            "title"    : title]
  }
}
