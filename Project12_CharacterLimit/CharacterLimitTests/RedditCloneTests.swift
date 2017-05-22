//
//  RedditCloneTests.swift
//  RedditCloneTests
//
//  Created by siwook on 2017. 4. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
import UIKit

@testable import RedditClone

// MARK : - RedditCloneTests: XCTestCase

class RedditCloneTests: XCTestCase {
  
  // MARK : - Property 
  
  var controllerUnderTest: PostListViewController!
  var submitTopicVCUnderTest : SubmitNewTopicViewController!
  var postInformationList:[PostInformation]!
  var bundleData:Data!
  
  // MARK : - Set Up
  
  override func setUp() {
    
    super.setUp()
    createTestViewControllers()
    createSamplePostInformationData()
  }
  
  func createTestViewControllers() {
    
    controllerUnderTest = UIStoryboard(name: Constants.Common.MainStoryboard ,
                                       bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.PostListViewController) as! PostListViewController
    
    submitTopicVCUnderTest = UIStoryboard(name: Constants.Common.MainStoryboard ,
                                       bundle: nil).instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.SubmitNewTopicViewController) as! SubmitNewTopicViewController
    _ = controllerUnderTest.view  // load view hierarchy
    _ = submitTopicVCUnderTest.view
  }
  
  func createSamplePostInformationData() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: Constants.Common.SampleJSONInput, ofType: Constants.Common.JSONType)
    bundleData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
  }

  func testLoadSampleDataFromBundle() {
    
    controllerUnderTest.loadSampleDataFromBundle()
    XCTAssertEqual(controllerUnderTest?.postList.count, 20, "couldn't fetch 20 items")
    
  }
  
  func testCreatePostListInPostInformationStruct() {
    
    do {
      let dictionaryArray = try(JSONSerialization.jsonObject(with: bundleData, options: .allowFragments)) as? [[String: AnyObject]]
      postInformationList = PostInformation.createPostList(dictionaryArray!)
      
      XCTAssertEqual(postInformationList.count, 20, "couldn't parse 20 items from bundle")
      
    } catch _ {}
  }

 
  func testSubmitNewTopicProtocolMethod() {
    
    submitTopicVCUnderTest.delegate = controllerUnderTest
    let newTopic = PostInformation(title: "test",postImage: UIImage(named:Constants.ImageName.Default)!,upvoteCount: 0)
    controllerUnderTest.updateListAfterSubmittingNewTopic(newTopic: newTopic)
  
    XCTAssertTrue(controllerUnderTest.postList.count == 21)
  }

  // MARK : - Tear Down
  
  override func tearDown() {
    clearTestVariables()
    super.tearDown()
  }
  
  func clearTestVariables() {
    postInformationList = nil
    controllerUnderTest = nil
    bundleData = nil
  }
  
  
}

extension RedditCloneTests {
  
  // MARK : - UITableView Tests
  
  func testControllerUnderTest_TableViewIsNotNilAfterViewDidLoad() {
    XCTAssertNotNil(controllerUnderTest.tableView)
  }
  
  func testControllerUnderTest_ShouldSetTableViewDataSource() {
    XCTAssertNotNil(controllerUnderTest.tableView.dataSource)
  }
  
  func testControllerUnderTest_ShouldSetTableViewDelegate() {
    XCTAssertNotNil(controllerUnderTest.tableView.delegate)
  }
  
  func testControllerUnderTest_ConformsToTableViewDataSourceProtocol() {
    XCTAssertTrue(controllerUnderTest.conforms(to: UITableViewDataSource.self))
  }
  
  func testTableViewNumberOfRowsInSection() {
    let expectedRows = 20
    XCTAssertTrue(controllerUnderTest.tableView.numberOfRows(inSection: 0) == expectedRows)
  }
  
  func testTableViewHeightForRowAtIndexPath() {
    
    let expectedHeight:CGFloat = 44
    let actualHeight = controllerUnderTest.tableView.rowHeight
    XCTAssertFalse(expectedHeight == actualHeight)
  }
  
  func testTableViewCellCreateCellsWithReuseIdentifier() {
    
    let indexPath = IndexPath(item: 0, section: 0)
    let cell = controllerUnderTest.tableView(controllerUnderTest.tableView, cellForRowAt: indexPath) as! PostInformationTableViewCell
    let expectedReuseIdentifier = Constants.CellIdentifier.PostInfoTableViewCell
    XCTAssertTrue( cell.reuseIdentifier == expectedReuseIdentifier )
  }
  
  func testTableViewCellUpvoteButtonAction() {
    
    do {
      let dictionaryArray = try(JSONSerialization.jsonObject(with: bundleData, options: .allowFragments)) as? [[String: AnyObject]]
      postInformationList = PostInformation.createPostList(dictionaryArray!)
    } catch _ {}
    
    let indexPath = IndexPath(item: 0, section: 0)
    var post = postInformationList[0]
    let expectedValue = post.upvoteCount + 1
    
    let cell = controllerUnderTest.tableView(controllerUnderTest.tableView, cellForRowAt: indexPath) as! PostInformationTableViewCell
    post.upvoteCount += 1
    cell.postInfo = post
    
    
    XCTAssertTrue(cell.postInfo.upvoteCount == expectedValue)
  }
  
  func testTableViewCellDownvoteButtonAction() {
    
    do {
      let dictionaryArray = try(JSONSerialization.jsonObject(with: bundleData, options: .allowFragments)) as? [[String: AnyObject]]
      postInformationList = PostInformation.createPostList(dictionaryArray!)
    } catch _ {}
    
    let indexPath = IndexPath(item: 0, section: 0)
    var post = postInformationList[0]
    let expectedValue = post.upvoteCount - 1
    
    let cell = controllerUnderTest.tableView(controllerUnderTest.tableView, cellForRowAt: indexPath) as! PostInformationTableViewCell
    post.upvoteCount -= 1
    cell.postInfo = post
    
    
    XCTAssertTrue(cell.postInfo.upvoteCount == expectedValue)
  }

}
