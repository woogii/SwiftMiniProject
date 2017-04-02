//
//  ReplyViewController.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2017. 3. 27..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import Foundation
import UIKit

// MARK : - ViewController: UIViewController

class ReplyViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var commentList:[Comment]!
  let questionCommentCell = "commentCell"
  let answerCommentCell = "answerCell"
  let messageInputAccessoryView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.isHidden = true
    return view
  }()
  let messageInputContainerView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    return view
  }()
  let inputTextField : UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter comment..."
    textField.becomeFirstResponder()
    return textField
  }()
  lazy var registerButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    let titleColor = UIColor.black
    button.setTitleColor(titleColor, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    return button
  }()
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    return view
  }()
  var bottomConstraint : NSLayoutConstraint?
  var insertedIndex:Int?
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureMessageInputContainerLayout()
    setupInputComponent()
    addKeyboardObserver()
  }
  
  func addKeyboardObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
  }
  
  func handleRegister() {
    
    let comment = Comment.createEnteredComment(text: inputTextField.text ?? "", name: "Kim", minuteAgo: 0, isQuestion: false)
    commentList.append(comment)
    
    let insertionIndexPath = IndexPath(item: commentList.count - 1, section: 0)
    
    tableView.beginUpdates()
    tableView.insertRows(at: [insertionIndexPath], with: .automatic)
    tableView.scrollToRow(at: insertionIndexPath, at: .top, animated: true)
    tableView.endUpdates()

    inputTextField.text = nil
  }
  
  func handleDismiss() {
    view.endEditing(true)
  }
  
  func handleKeyboardNotification(notification:Notification) {
    
    if let userInfo = notification.userInfo {
      
      let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
      let isKeyboardShowing = notification.name == .UIKeyboardWillShow
      isKeyboardShowing ? (messageInputAccessoryView.isHidden = false) : (messageInputAccessoryView.isHidden = true)
      bottomConstraint?.constant = isKeyboardShowing ?  -keyboardFrame.height :  0
      
      UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
        
        self.view.layoutIfNeeded()
        
      }, completion: { (completed) in
        
      })
    }
    
  }
  
  fileprivate func configureMessageInputContainerLayout() {
    
    view.addSubview(messageInputContainerView)
    view.addSubview(messageInputAccessoryView)
    
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
    view.addConstraintsWithFormat(format: "V:[v0(40)]", views: messageInputContainerView)
    
    bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    view.addConstraint(bottomConstraint!)
  }
  
  fileprivate func setupInputComponent() {
    
    messageInputContainerView.addSubview(inputTextField)
    messageInputContainerView.addSubview(registerButton)
    messageInputContainerView.addSubview(separatorView)
    
    messageInputContainerView.addConstraintsWithFormat(format: "H:|-8-[v0][v1(60)]|", views: inputTextField, registerButton)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: registerButton)
    messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(1)]", views: separatorView)
  }

}


// MARK : - ViewController:  UITableViewDelegate, UITableViewDataSource

extension ReplyViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK : - UITableViewDataSource Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let singleComment = commentList[indexPath.row]
    
    if singleComment.isQuestion {
      let cell = tableView.dequeueReusableCell(withIdentifier: questionCommentCell, for: indexPath) as! CommentTableViewCell
      cell.questionComment = singleComment
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: answerCommentCell, for: indexPath) as! AnswerTableViewCell
      cell.answerComment = singleComment
      cell.tag = indexPath.row
      return cell
    }
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




