//
//  Project04_CommentSystemTests.swift
//  Project04_CommentSystemTests
//
//  Created by TeamSlogup on 2016. 10. 10..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import XCTest
@testable import Project04_CommentSystem

class Project04_CommentSystemTests: XCTestCase {
  
  let numberOfExpectedComments = 11
  
  override func setUp() {
    super.setUp()
  }
    
  override func tearDown() {
    super.tearDown()
  }
  
  func testCommentListHasExpectedItemsCount() {
    let commentList = Comment.createCommentList()
    XCTAssert(commentList.count == numberOfExpectedComments)
  }
  
  
  
}
