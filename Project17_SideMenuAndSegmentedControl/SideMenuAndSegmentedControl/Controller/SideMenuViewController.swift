//
//  SideMenuViewController.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 7. 2..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - SideMenuViewController : UIViewController

class SideMenuViewController: UITableViewController {

  // MARK : - Property

  let syncDateFormatter: DateFormatter = {
    let syncDateFormatter = DateFormatter()
    syncDateFormatter.locale = Locale(identifier: "en_SG")
    syncDateFormatter.dateFormat = "yyyy.MM.dd h:mm a"
    syncDateFormatter.amSymbol = "am"
    syncDateFormatter.pmSymbol = "pm"
    return syncDateFormatter
  }()
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableViewInset()
  }
  private func setTableViewInset() {
    tableView.contentInset = UIEdgeInsets(top: 36.0, left: 0.0, bottom: 44.0, right: 0.0)
  }

  // MARK : - UITableView Datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.MenuTitle.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.SideMenuTableViewCell,
                                                   for: indexPath) as? SideMenuTableViewCell else {
      return SideMenuTableViewCell()
    }

    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }
  func configureCell(cell: SideMenuTableViewCell, indexPath: IndexPath) {
    adjustLeadingConstraintBasedOnMenuType(cell: cell, indexPath: indexPath)
    hideIconImageViewBasedOnMenuType(cell: cell, indexPath: indexPath)
    setIconImageViewBasedOnMenuType(cell: cell, indexPath: indexPath)
    setMenuTitle(cell: cell, indexPath: indexPath)
    setSyncDate(cell: cell, indexPath: indexPath)
  }

  private func setSyncDate(cell: SideMenuTableViewCell, indexPath: IndexPath) {
    if indexPath.row == MenuType.Sync.rawValue {
      cell.syncDateLabel.isHidden = false
      cell.syncDateLabel.text = Constants.SideMenuVC.SyncDateInfoDefaultText + Constants.SideMenuVC.DefaultSyncDate
    }
  }
  private func setMenuTitle(cell: SideMenuTableViewCell, indexPath: IndexPath) {
    cell.titleLabel.text = Constants.MenuTitle[indexPath.row]
  }
  private func adjustLeadingConstraintBasedOnMenuType(cell: SideMenuTableViewCell, indexPath: IndexPath) {
    if indexPath.row == MenuType.Books.rawValue
         || indexPath.row == MenuType.Newsstand.rawValue
           || indexPath.row == MenuType.Docs.rawValue {
      cell.titleLabelLeadingConstraint.constant = Constants.SideMenuVC.SecondDepthMenuLeadingConstraintValue
    } else {
      cell.titleLabelLeadingConstraint.constant = Constants.SideMenuVC.FirstDepthMenuLeadingConstraintValue
    }
  }
  private func hideIconImageViewBasedOnMenuType(cell: SideMenuTableViewCell, indexPath: IndexPath) {
    if indexPath.row == MenuType.Search.rawValue
        || indexPath.row == MenuType.Sync.rawValue
         || indexPath.row == MenuType.Settings.rawValue {
      cell.menuIconImageView.isHidden = false
    }

  }

  private func setIconImageViewBasedOnMenuType(cell: SideMenuTableViewCell, indexPath: IndexPath) {
    if indexPath.row == MenuType.Search.rawValue {
      cell.menuIconImageView.image = #imageLiteral(resourceName: "ic_search")
    } else if indexPath.row == MenuType.Sync.rawValue {
      cell.menuIconImageView.image = #imageLiteral(resourceName: "ic_synchronize")
    } else if indexPath.row == MenuType.Settings.rawValue {
      cell.menuIconImageView.image = #imageLiteral(resourceName: "ic_settings")
    }

  }

  // MARK : - UITableView Delegate Methods

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let mainViewController = sideMenuController!
    guard let cell = tableView.cellForRow(at: indexPath) as? SideMenuTableViewCell else {
      return
    }
    switch indexPath.row {

    case MenuType.Search.rawValue:

      let main = UIStoryboard.init(name: Constants.StorybordName.Main, bundle: nil)
      guard let searchBookVC = main.instantiateViewController(
        withIdentifier: Constants.StoryboardID.SearchBookVC) as? SearchBookViewController else {
        return
      }
      guard let navigationController = mainViewController.rootViewController as? UINavigationController else {
        return
      }
      navigationController.present(searchBookVC, animated: true, completion: nil)
      mainViewController.hideLeftView(animated: true, completionHandler: nil)

      break

    case MenuType.Sync.rawValue:

      rotateIconImageView(cell.menuIconImageView)

      DispatchQueue.main.asyncAfter(deadline: .now() + Constants.SideMenuVC.RotateAnimationDelay, execute: {
        self.stopRotatingIconImageView(cell.menuIconImageView)
        self.changeBackgroundAndSetSyncDate(cell)
      })

      break
    default:
      break
    }

    tableView.deselectRow(at: indexPath, animated: true)
  }

  func changeBackgroundAndSetSyncDate(_ cell: SideMenuTableViewCell) {

    UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseOut, .curveEaseIn], animations: {

      cell.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.3)

    }, completion: { finished in
      if finished {
        cell.contentView.backgroundColor = UIColor.clear
        cell.syncDateLabel.text = Constants.SideMenuVC.SyncDateInfoDefaultText
                                    + self.syncDateFormatter.string(from: Date())

      }
    })

  }

  func rotateIconImageView(_ view: UIView, duration: Double = 1.5) {
    if view.layer.animation(forKey: Constants.SideMenuVC.RotationAnimationKey) == nil {
      let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
      rotationAnimation.fromValue = 0.0
      rotationAnimation.toValue = Float(Double.pi * 2.0)
      rotationAnimation.duration = duration
      rotationAnimation.repeatCount = Float.infinity
      view.layer.add(rotationAnimation, forKey: Constants.SideMenuVC.RotationAnimationKey)
    }
  }
  func stopRotatingIconImageView(_ view: UIView) {
    if view.layer.animation(forKey: Constants.SideMenuVC.RotationAnimationKey) != nil {
      view.layer.removeAnimation(forKey: Constants.SideMenuVC.RotationAnimationKey)
    }
  }
}
