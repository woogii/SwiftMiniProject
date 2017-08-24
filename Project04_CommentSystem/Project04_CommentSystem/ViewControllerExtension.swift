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
    
    let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let writeCommentVCAction = UIAlertAction(title: "Reply", style: .default, handler: { action in
      
      if self.commentList[cellIndex].isQuestion == true {
  
        let indexPairs = self.getIndexesWhenQuestionSelected(cellIndex: cellIndex)
        self.prepareToWriteComment(commentStartIndex: indexPairs.0,commentLastIndex: indexPairs.1)
    
      } else {
        
        let indexPairs = self.getIndexesWhenAnswerSelected(cellIndex: cellIndex)
        self.prepareToWriteComment(commentStartIndex: indexPairs.0,commentLastIndex: indexPairs.1)
      }
      
    })
  
    actionSheetController.addAction(writeCommentVCAction)
    
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    actionSheetController.addAction(cancelAction)
    
    present(actionSheetController, animated: true, completion: nil)
    
    
  }
  
  func getIndexesWhenAnswerSelected(cellIndex:Int)->(startQuestionIndex:Int,endAnswerIndex:Int) {
    
    let startIndex = self.findPrevQuestionIndex(cellIndex: cellIndex)
    
    if let endIndex = self.findNextQuestionIndex(cellIndex: cellIndex) {
      return (startIndex!, endIndex-1)
    } else {
      return (startIndex!, commentList.count - 1)
    }
    
  }
  
  func getIndexesWhenQuestionSelected(cellIndex:Int)->(startQuestionIndex:Int,endAnswerIndex:Int) {
    
    var startIndex:Int!
    var endIndex:Int!
    
    if let index = self.findNextQuestionIndex(cellIndex: cellIndex) {

      if index != cellIndex {
        startIndex = cellIndex
        endIndex = index - 1
      } else {
        startIndex = cellIndex
        endIndex = cellIndex
      }
    } else {
      startIndex = cellIndex
      endIndex = commentList.count - 1
    }

    return (startIndex, endIndex)
    
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
  
  func prepareToWriteComment(commentStartIndex:Int, commentLastIndex:Int) {
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let destinationVC = storyBoard.instantiateViewController(withIdentifier: "replyVC") as! ReplyViewController
    destinationVC.commentList = Array(commentList[commentStartIndex...commentLastIndex])
    destinationVC.insertedIndex = commentLastIndex
    destinationVC.delegate = self
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

extension ViewController : ReplyViewControllerDelegate {
  
  func updateCommentList(newComment:Comment,index:Int) {

    index == commentList.count - 1 ? commentList.append(newComment) : commentList.insert(newComment, at: index + 1)
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

