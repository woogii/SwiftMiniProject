//
//  ViewController.swift
//  LogInDemo
//
//  Created by siwook on 2017. 6. 5..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

// MARK : - LogInViewController: UIViewController

class LogInViewController: UIViewController {

  // MARK : - Property 

  @IBOutlet weak var logInButton: UIButton!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var emailCheckerImageView: UIImageView!
  @IBOutlet weak var passwordCheckerImageView: UIImageView!
  @IBOutlet weak var facebookLogInButton: UIButton!
  @IBOutlet weak var googleLogInButton: UIButton!

  fileprivate let inputValidator = InputValidator()
  fileprivate var user: UserInfo!
  fileprivate var emailValidateResult = false
  fileprivate var passwordValidateResult = false
  // MARK : - View Life Cycle

  override func viewDidLoad() {

    super.viewDidLoad()

    addAuthStateChangeListener()
    addGradientForBackground()
    hideKeyboardWhenTappedAround()
    applyRadiusToButtons()
    changeLogInButtonImageTintColor()
    setCheckImageViewHiddenStatus()
    setGoogleSignInDelegate()
  }

  private func addAuthStateChangeListener() {
    Auth.auth().addStateDidChangeListener { _, user in
      if user != nil {
        self.performSegue(withIdentifier: Constants.SegueID.ShowBookListVC, sender: nil)
      }
    }
  }
  private func setGoogleSignInDelegate() {
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self
  }

  private func setCheckImageViewHiddenStatus() {
    emailCheckerImageView.isHidden = true
    passwordCheckerImageView.isHidden = true
  }

  private func changeLogInButtonImageTintColor() {
    let image = logInButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
    logInButton.imageView?.image = image
    logInButton.imageView?.tintColor = Constants.Color.BgGradientDarkColor
  }

  private func applyRadiusToButtons() {
    logInButton.layer.cornerRadius = logInButton.frame.width/2
    logInButton.layer.masksToBounds = true
    facebookLogInButton.layer.cornerRadius = facebookLogInButton.frame.size.height/2
    googleLogInButton.layer.cornerRadius = googleLogInButton.frame.size.height/2
  }

  private func addGradientForBackground() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.bounds
    gradientLayer.colors = [Constants.Color.BgGradientLightColor.cgColor, Constants.Color.BgGradientDarkColor.cgColor]
    gradientLayer.startPoint = CGPoint(x:1, y:1)
    gradientLayer.endPoint = CGPoint(x:0, y:1)
    self.view.layer.insertSublayer(gradientLayer, at: 0)
  }

  // MARK : - Target Actions 

  @IBAction func tappedLogInButton(_ sender: UIButton) {

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    view.addSubview(activityIndicator)
    activityIndicator.center = view.center
    activityIndicator.startAnimating()

    Auth.auth().signIn(withEmail: emailTextField.text!,
                       password: passwordTextField.text!,
                       completion: { (user, error) in

      activityIndicator.removeFromSuperview()

      if error != nil {
        self.showAlertWith(message: (error?.localizedDescription)!, error: error)
      } else {
        self.showAlertWith(message: Constants.Message.LogInSuccess, error: nil)
        self.user = UserInfo(user: user!)

      }
    })
  }

  private func moveToBookListVC() {
    performSegue(withIdentifier: Constants.SegueID.ShowBookListVC, sender: self)
  }

  private func initSubViewsStatus() {
    emailTextField.text = ""
    passwordTextField.text = ""
    logInButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    logInButton.isEnabled = false
    emailValidateResult = false
    passwordValidateResult = false
    emailCheckerImageView.isHidden = true
    passwordCheckerImageView.isHidden = true
  }

  @IBAction func tappedGoogleLogInButton(_ sender: UIButton) {
    GIDSignIn.sharedInstance().signIn()
  }

  @IBAction func tappedFacebookLogInButton(_ sender: UIButton) {

    let loginManager: FBSDKLoginManager = FBSDKLoginManager()

    if FBSDKAccessToken.current() != nil {
      loginManager.logOut()
    }

    let facebookReadPermission = [Constants.FacebookAPI.Permission.PublicProfile,
                                  Constants.FacebookAPI.Permission.Email]

    loginManager.logIn(withReadPermissions: facebookReadPermission, from:self, handler: { (result, error) -> Void in

      if error != nil {
        loginManager.logOut()
      } else if (result?.isCancelled)! {
        loginManager.logOut()
      } else {

        var allPermsGranted = true

        let grantedPermissions = Array(result!.grantedPermissions).map({"\($0)"})

        for permission in facebookReadPermission {

          if !grantedPermissions.contains(permission) {
            allPermsGranted = false
            break
          }
        }

        if allPermsGranted {

          let accessToken  = FBSDKAccessToken.current().tokenString

          let credential = FacebookAuthProvider.credential(withAccessToken: accessToken!)

          Auth.auth().signIn(with: credential) { (user, error) in

            if let error = error {
              self.showAlertWith(message: error.localizedDescription, error:error)
              return
            } else {
              self.showAlertWith(message: Constants.Message.LogInSuccess, error: nil)
              print(user!)
              self.user = UserInfo(user: user!)
            }
          }

        }
      }
    })

  }

  // MARK : - Show Alert Message

  func showAlertWith(message: String, error: Error?) {

    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: Constants.Title.Okay, style: .default, handler: { _ in
      DispatchQueue.main.async {
        if error == nil {
          self.moveToBookListVC()
          self.initSubViewsStatus()
        }
      }
    })
    alertController.addAction(okAction)

    self.present(alertController, animated: true, completion: nil)
  }
}

// MARK : - LogInViewController : GIDSignInDelegate, GIDSignInUIDelegate
extension LogInViewController: GIDSignInDelegate, GIDSignInUIDelegate {

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

    if let error = error {
      showAlertWith(message: error.localizedDescription, error: error)
      return
    }

    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                   accessToken: authentication.accessToken)
    Auth.auth().signIn(with: credential) { (user, error) in

      if let error = error {
        self.showAlertWith(message: error.localizedDescription, error: error)
        return
      } else {
        self.showAlertWith(message: Constants.Message.LogInSuccess, error: nil)
        print(user!)
        self.user = UserInfo(user: user!)
      }
    }

  }

  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

    do {
      try Auth.auth().signOut()
    } catch let error {
      print(error.localizedDescription)
    }
  }

}

// MARK : - LogInViewController : UITextFieldDelegate 

extension LogInViewController : UITextFieldDelegate {

  // MARK : - UITextFieldDelegate Delegate Methods

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    let textFieldText: NSString = (textField.text ?? "") as NSString
    let textAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)

    if textField == emailTextField {
      validateEmail(text:textAfterUpdate)
    } else if textField == passwordTextField {

      guard textAfterUpdate.characters.count <= Constants.PasswordLimitCount else {
        return false
      }

      // ref. https://stackoverflow.com/a/17182871/5657370
      if range.location > 0 && range.length == 1 && string.characters.count == 0 {
        // Stores cursor position
        let beginning = textField.beginningOfDocument
        let start = textField.position(from: beginning, offset: range.location)
        let cursorOffset = textField.offset(from: beginning, to: start!) + string.characters.count

        // Save the current text, in case iOS deletes the whole text
        let nsString = textField.text as NSString?

        // Trigger deletion
        textField.deleteBackward()

        // iOS deleted the entire string
        if (textField.text?.characters.count)! != (nsString?.length)! - 1 {
          textField.text = nsString?.replacingCharacters(in: range, with: string)

          // Update cursor position
          let newCursorPosition = textField.position(from: textField.beginningOfDocument, offset:cursorOffset)

          let newSelectedRange = textField.textRange(from: newCursorPosition!, to: newCursorPosition!)
          textField.selectedTextRange = newSelectedRange
        }

        validatePassword(text:textAfterUpdate)
        setButtonStatusBasedOnValidateResult(validationResult: (emailValidateResult, passwordValidateResult))

        return false
      } else {
        validatePassword(text:textAfterUpdate)
      }
    }

    setButtonStatusBasedOnValidateResult(validationResult: (emailValidateResult, passwordValidateResult))

    return true
  }

  func validateEmail(text: String) {
    emailValidateResult = inputValidator.validateEmail(text: text)
    emailCheckerImageView.isHidden = !emailValidateResult
  }

  func validatePassword(text: String) {
    passwordValidateResult = inputValidator.validatePassword(text: text)
    passwordCheckerImageView.isHidden = !passwordValidateResult
  }

  func setButtonStatusBasedOnValidateResult(validationResult:(email: Bool, password: Bool)) {

    if validationResult.email && validationResult.password {
      logInButton.isEnabled = true
      logInButton.backgroundColor = UIColor.white
    } else {
      logInButton.isEnabled = false
      logInButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
  }
}

// MARK : - LogInViewController Extension

extension LogInViewController {

  func hideKeyboardWhenTappedAround() {

    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
    view.addGestureRecognizer(tapRecognizer)
  }

  func dismissKeyboard() {
    view.endEditing(true)
  }
}
