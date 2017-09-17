//
//  Book.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 26..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import Firebase

// MARK : - Book 

struct Book {

  // MARK : - Property
  let key: String
  let author: String
  let publisher: String
  let title: String
  let ref: DatabaseReference?

  // MARK : - Initialization
  init(key: String, author: String, publisher: String, title: String) {

    self.key = key
    self.author = author
    self.publisher = publisher
    self.title = title
    self.ref = nil
  }

  init(snapshot: DataSnapshot) {
    self.key = snapshot.key
    let snapshotValue = snapshot.value as? [String:Any] ?? [String: Any]()
    self.author = snapshotValue[Constants.DataSnapshotKey.Author] as? String  ?? ""
    self.title = snapshotValue[Constants.DataSnapshotKey.Title] as? String ?? ""
    self.publisher = snapshotValue[Constants.DataSnapshotKey.Publisher] as? String ?? ""
    self.ref = snapshot.ref
  }

  func toAnyObject()-> Any {
    return [Constants.DataSnapshotKey.Author: author,
            Constants.DataSnapshotKey.Publisher: publisher,
            Constants.DataSnapshotKey.Title: title]
  }
}
