//
//  UIViewController+PresentAlert.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 27..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK: - UIViewController Extension
extension UIViewController {
  // MARK: - Show UIAlertController
  func showAlert(withTitle title: String?,
                 message: String?,
                 showCancelButton: Bool,
                 okButtonTitle: String,
                 okButtonCallback: (() -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertOkAction = UIAlertAction(title: okButtonTitle,
                                      style: .default) { _ in
                                        guard let callback = okButtonCallback else { return }
                                        callback()
    }
    alert.addAction(alertOkAction)
    if showCancelButton {
      let cancelAction = UIAlertAction(title: Constants.Titles.CancelButton,
                                       style: .cancel, handler: nil)
      alert.addAction(cancelAction)
    }
    present(alert, animated: true, completion: nil)
  }
}
