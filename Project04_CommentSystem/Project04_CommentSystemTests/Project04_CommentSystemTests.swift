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
  var commentVCUnderTest: ViewController!
  var replyVCUnderTest:ReplyViewController!
  
  override func setUp() {
    super.setUp()
    
    createViewControllers()
  }
  
  func createViewControllers() {
    commentVCUnderTest = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "commentVC") as! ViewController
    replyVCUnderTest = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "replyVC") as! ReplyViewController
    
  }
  
  override func tearDown() {
  
    deallocViewControllers()
    super.tearDown()
  }
  
  func deallocViewControllers() {
    commentVCUnderTest = nil
    replyVCUnderTest = nil
  }
  
  func createCommentList()->[Comment] {
    return Comment.createCommentList()
  }
  
  func testCommentListHasExpectedItemsCount() {
    let commentList = createCommentList()
    XCTAssert(commentList.count == numberOfExpectedComments)
  }
  
  func testAddASingleCommentToCommentList() {
    // given
    var commentList = createCommentList()
    
    // when
    let singleComment = Comment.createEnteredComment(text: "test", name: "testString", minuteAgo: 2, isQuestion: true)
    commentList.append(singleComment)
    
    // then 
    XCTAssertEqual(commentList.count, numberOfExpectedComments + 1, "An Entered comment was not added")
  }
  
  func testRegisteringCommentInViewController() {
    let commentList = createCommentList()
    
    commentVCUnderTest.viewDidLoad()
    commentVCUnderTest.addEnteredComment()

    
    XCTAssertEqual(commentList.count, numberOfExpectedComments , "The handleRegister in ViewController is not working properly")
  }
  
}
