//
//  Comment.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2017. 3. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation

struct Comment {
  
  var text:String
  var name:String
  var date:Date
  var isQuestion:Bool
  
  init(text:String, name:String, date:Date, isQuestion:Bool) {
    self.text = text
    self.name = name
    self.date = date
    self.isQuestion = isQuestion
  }
  
  static func createCommentList()->[Comment] {
  
    var commentList = [Comment]()
    
    for i in 0...10 {
      
      let comment:Comment!
      
      if i%2 == 0 {
        comment = Comment(text: "\(i+1). This is a question", name: "Kim", date: Date().addingTimeInterval(-Double(i)*60), isQuestion: true)
      } else {
        comment = Comment(text: "\(i+1). This is an answer", name: "Tom", date: Date().addingTimeInterval(-Double(i)*60), isQuestion: false)
      }
      commentList.append(comment)
    }
    
    return commentList
  }
  
  static func createEnteredComment(text:String, name:String, minuteAgo : Double, isQuestion:Bool)->Comment {
    return Comment(text: text, name: name, date: Date().addingTimeInterval(-minuteAgo * 60), isQuestion: isQuestion)
  }
}
