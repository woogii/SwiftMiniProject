//
//  KeywordInputViewController.swift
//  SearchInterface
//
//  Created by siwook on 2017. 4. 4..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - KeywordInputViewControllerDelegate (Protocol)

protocol KeywordInputViewControllerDelegate: class {
  func passSearchKeyword(searchKeyword: String)
}

// MARK : - KeywordInputViewController : UIViewController
class KeywordInputViewController: UIViewController {
  // MARK :  - Property
  @IBOutlet weak var inputContainerView: UIView!
  @IBOutlet weak var searchIconImageView: UIImageView!
  @IBOutlet weak var inputTextField: UITextField!
  weak var delegate: KeywordInputViewControllerDelegate?
  var keywordString: String?
  // MARK :  - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setCornerRadiusForContainerView()
    displayNavigationBarBasedOn(hiddenStatus:true)
    setIconImageViewColor()
    configureInputTextField()
  }
  func setCornerRadiusForContainerView() {
    inputContainerView.layer.cornerRadius = Constants.CornerRadiusValue
    inputContainerView.layer.masksToBounds = true
  }
  func configureInputTextField() {
    inputTextField.text = keywordString ?? ""
  }
  func setIconImageViewColor() {
    let image = UIImage(named: Constants.Icons.SearchIcon)
    searchIconImageView.image = image?.withRenderingMode(.alwaysTemplate)
    searchIconImageView.tintColor = UIColor.white
  }
  func displayNavigationBarBasedOn(hiddenStatus: Bool) {
    navigationController?.setNavigationBarHidden(hiddenStatus, animated: true)
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    displayNavigationBarBasedOn(hiddenStatus:false)
  }
  @IBAction func pushBackButton(_ sender: UIBarButtonItem) {
    _ = navigationController?.popViewController(animated: true)
  }
  @IBAction func pushCancelButton(_ sender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
}
extension KeywordInputViewController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    delegate?.passSearchKeyword(searchKeyword: textField.text ?? "")
    _ = navigationController?.popViewController(animated: true)
    return true
  }
}
