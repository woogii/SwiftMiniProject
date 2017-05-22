//
//  SubmitNewTopicViewController.swift
//  RedditClone
//
//  Created by siwook on 2017. 4. 24..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - SubmitNewTopicViewControllerDelegate 

protocol SubmitNewTopicViewControllerDelegate {
  func updateListAfterSubmittingNewTopic(newTopic:PostInformation)
}

// MARK : - SubmitNewTopicViewController : UIViewController

class SubmitNewTopicViewController : UIViewController {
  
  // MARK : - Property
  
  @IBOutlet weak var inputTextView: UITextView!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var textCountLabel: UILabel!
  var delegate : SubmitNewTopicViewControllerDelegate?
  
  lazy var flexButton: UIBarButtonItem = {
    let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,target: nil, action: nil)
    return flexButton
    
  }()
  lazy var doneButton: UIBarButtonItem = {
    let doneButton = UIBarButtonItem(title: Constants.Common.Ok , style: .plain, target: self, action: #selector(endEditing(_:)))
    return doneButton
  }()
  
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setCornerRadiusForSubmitButton()
    setTextViewBorderColor()
    addKeyboardToolBar()
    setTextViewAsFirstResponder()
    
  }
  
  private func setCornerRadiusForSubmitButton() {
    submitButton.layer.cornerRadius = submitButton.frame.size.height/2
  }
  
  private func setTextViewBorderColor() {
    inputTextView.layer.borderColor = UIColor.lightGray.cgColor
  }

  private func setTextViewAsFirstResponder() {
    inputTextView.becomeFirstResponder()
  }
  
  // MARK : - Add Keybord Toolbar
  
  private func addKeyboardToolBar() {
    
    inputTextView.inputAccessoryView = createKeyboardToolbar()
  }
  
  fileprivate func createKeyboardToolbar()-> UIToolbar {
    
    let keyboardToolbar = UIToolbar()

    keyboardToolbar.tintColor = UIColor.black
    keyboardToolbar.sizeToFit()
    keyboardToolbar.items = [flexButton, doneButton]
  
    return keyboardToolbar
  }
  
  func endEditing(_ sender:UIBarButtonItem) {
    self.view.endEditing(true)
  }


  // MARK : - Target Actions

  @IBAction func tapBackToTheListButton(_ sender: UIBarButtonItem) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  @IBAction func tapSubmitButton(_ sender: UIButton) {
    
    inputTextView.endEditing(true)
    
    if inputTextView.text.isEmpty {
      showValidateErrorAlert()
    } else {
      showSuccessAlert()
      let newTopic = PostInformation(title: inputTextView.text,postImage: UIImage(named:Constants.ImageName.Default)!,upvoteCount: 0)
      delegate?.updateListAfterSubmittingNewTopic(newTopic: newTopic)
    }
  }
  
  // MARK : - Present AlertController
  
  fileprivate func showValidateErrorAlert() {
    
    let alert = UIAlertController(title: "", message: Constants.SubmitNewTopicVC.EnterTopicDescription, preferredStyle: .alert)
    let alertOkAction = UIAlertAction(title: Constants.Common.Ok, style: .default)
    alert.addAction(alertOkAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  fileprivate func showSuccessAlert() {
    let alert = UIAlertController(title: "", message: Constants.SubmitNewTopicVC.TopicIsSubmitted, preferredStyle: .alert)
    let alertOkAction = UIAlertAction(title: Constants.Common.Ok, style: .default, handler: { (action) in
      _ = self.navigationController?.popViewController(animated: true)
    })
    alert.addAction(alertOkAction)
    
    present(alert, animated: true, completion: nil)
  }
}

// MARK : - SubmitNewTopicViewController : UITextViewDelegate

extension SubmitNewTopicViewController : UITextViewDelegate {
  
  // MARK : - UITextViewDelegate Methods 
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    print(textView.text.characters.count)
    if text.characters.count == 0 {  // When the delete key is entered
      
      if textView.text.characters.count != 0 {  // Delete key is only allowed when texts exist
        return true
      }
    } else if textView.text.characters.count > (Constants.SubmitNewTopicVC.MaximumTopicCount-1) {
      // limit the number of input to 255
      return false
    }
      
    return true

  }
  
  func textViewDidChange(_ textView: UITextView) {
    
    if textView == inputTextView {
      let textLength = textView.text.characters.count
      textCountLabel.text = "\(textLength)" + "/" + "\(Constants.SubmitNewTopicVC.MaximumTopicCount)"
    }
  }
  
}







