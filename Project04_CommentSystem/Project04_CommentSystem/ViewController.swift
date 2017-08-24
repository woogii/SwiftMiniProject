//
//  ViewController.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2016. 10. 10..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController
  
class ViewController: UIViewController {
  
  // MARK : - Property 
  
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
  
  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
  
    fetchCommentList()
    configureMessageInputContainerLayout()
    setupInputComponent()
    addKeyboardObserver()
    
  }
  
  private func addKeyboardObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
  }
  
  func handleRegister() {
    
    addEnteredComment()
    updateUIAfterAddComment()
  }
  
  private func updateUIAfterAddComment() {
    updateTableView()
    updateInputTextField()
  }
  
  private func updateTableView() {
    let insertionIndexPath = IndexPath(item: 0, section: 0)
  
    tableView.beginUpdates()
    tableView.insertRows(at: [insertionIndexPath], with: .automatic)
    tableView.scrollToRow(at: insertionIndexPath, at: .top, animated: true)
    tableView.endUpdates()
  }
  
  private func updateInputTextField() {
      inputTextField.text = nil
  }
  
  private func addEnteredComment() {
    let comment = Comment.createEnteredComment(text: inputTextField.text ?? "", name: "Kim", minuteAgo: 0, isQuestion: true)
    commentList.insert(comment, at: 0)
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
  
  private func fetchCommentList() {
    commentList = Comment.createCommentList()
  }

  private func configureMessageInputContainerLayout() {
    
    view.addSubview(messageInputContainerView)
    view.addSubview(messageInputAccessoryView)
    
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
    view.addConstraintsWithFormat(format: "V:[v0(40)]", views: messageInputContainerView)
    
    bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    view.addConstraint(bottomConstraint!)
  }
  
  private func setupInputComponent() {
    
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

