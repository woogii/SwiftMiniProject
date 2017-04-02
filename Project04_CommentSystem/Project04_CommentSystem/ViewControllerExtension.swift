//
//  ViewControllerExtension.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2017. 3. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
import UIKit

// MARK : - ViewController:  UITableViewDelegate, UITableViewDataSource

extension ViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK : - UITableViewDataSource Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let singleComment = commentList[indexPath.row]
    
    if singleComment.isQuestion {
      let cell = tableView.dequeueReusableCell(withIdentifier: questionCommentCell, for: indexPath) as! CommentTableViewCell
      cell.questionComment = singleComment
      cell.tag = indexPath.row
      addTapGestureForCell(cell: cell)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: answerCommentCell, for: indexPath) as! AnswerTableViewCell
      cell.answerComment = singleComment
      cell.tag = indexPath.row
      addTapGestureForCell(cell: cell)
      return cell
    }
    
  }
  
  func addTapGestureForCell(cell:UITableViewCell) {
    
    view.endEditing(true)
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapComment(_:)))
    tapRecognizer.numberOfTapsRequired = 1
    tapRecognizer.numberOfTouchesRequired = 1
    
    cell.addGestureRecognizer(tapRecognizer)
    
  }
  
  
  func tapComment(_ gestureRecognizer : UIGestureRecognizer) {
    
    let cellIndex = gestureRecognizer.view!.tag
    print("Cell Index : \(cellIndex)")
    let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    var passedCommentList:[Comment]!
    
    let writeCommentVCAction = UIAlertAction(title: "Reply", style: .default, handler: { action in
      
      if self.commentList[cellIndex].isQuestion == true {
        
        passedCommentList = self.getPartialListStartFromQuestion(cellIndex:cellIndex)
        self.prepareToWriteComment(self.commentList[cellIndex],passedCommentList: passedCommentList)
        
        
      } else {
        
        passedCommentList = self.getPartialListIncludingCurrentAnswer(cellIndex: cellIndex)
        self.prepareToWriteComment(self.commentList[cellIndex],passedCommentList: passedCommentList)
      }
      
    })
  
    actionSheetController.addAction(writeCommentVCAction)
    
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    actionSheetController.addAction(cancelAction)
    
    present(actionSheetController, animated: true, completion: nil)
    
    
  }
  
  func getPartialListIncludingCurrentAnswer(cellIndex:Int)->[Comment] {
    
    let startIndex = self.findPrevQuestionIndex(cellIndex: cellIndex)
    
    if let lastIndex = self.findNextQuestionIndex(cellIndex: cellIndex) {
      return Array(self.commentList[startIndex!...lastIndex-1])
    } else {
      return Array(self.commentList[startIndex!...self.commentList.count - 1])
    }
    
  }
  
  func getPartialListStartFromQuestion(cellIndex:Int)->[Comment] {
    
    let partialCommentList:[Comment]!
    
    if let index = self.findNextQuestionIndex(cellIndex: cellIndex) {
      
      if index != cellIndex {
        partialCommentList = Array(self.commentList[cellIndex...index-1])
      } else {
        // if current cell is the question cell and is located at the last index
        partialCommentList = [self.commentList[cellIndex]]
      }
    } else {
      partialCommentList = Array(self.commentList[cellIndex...self.commentList.count-1])
    }

    return partialCommentList
  }
  

  func findPrevQuestionIndex(cellIndex:Int)->Int? {
    
    let subCommentList = Array(self.commentList[0...cellIndex-1].reversed())
    guard let index = subCommentList.index(where: {$0.isQuestion == true}) else {
      return nil
    }
    return subCommentList.count - 1 - index
  }
  
  func findNextQuestionIndex(cellIndex:Int)->Int? {
    
    guard cellIndex != commentList.count - 1 else {
      return cellIndex
    }
    
    let subCommentList = self.commentList[cellIndex+1...self.commentList.count-1]
    let index = subCommentList.index(where: {$0.isQuestion == true})
    return index
  }
  
  func prepareToWriteComment(_ comment:Comment,passedCommentList:[Comment]) {
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let destinationVC = storyBoard.instantiateViewController(withIdentifier: "replyVC") as! ReplyViewController
    destinationVC.commentList = passedCommentList
     
    navigationController?.pushViewController(destinationVC, animated: true)
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return commentList.count
  }
  
  // MARK : - UITableViewDelegate Methods
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    inputTextField.endEditing(true)
  }
  
}


extension UIView {
  
  func addConstraintsWithFormat(format: String, views: UIView...) {
    
    var viewDictionary = [String: UIView]()
    
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                       options: NSLayoutFormatOptions(),
                                                       metrics: nil,
                                                       views: viewDictionary))
  }
  
}
