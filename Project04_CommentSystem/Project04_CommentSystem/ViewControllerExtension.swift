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
      addTapGestureForCell(cell: cell)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: answerCommentCell, for: indexPath) as! AnswerTableViewCell
      cell.answerComment = singleComment
      return cell
    }
    
  }
  
  func addTapGestureForCell(cell:CommentTableViewCell) {
    
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
      self.prepareToWriteComment(self.commentList[cellIndex])
    })
    actionSheetController.addAction(writeCommentVCAction)
    
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
    actionSheetController.addAction(cancelAction)
    
    present(actionSheetController, animated: true, completion: nil)
    
    
  }
  
  func prepareToWriteComment(_ comment:Comment) {
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let destinationVC = storyBoard.instantiateViewController(withIdentifier: "replyVC") as! ReplyViewController
  
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
