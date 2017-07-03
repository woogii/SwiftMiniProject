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

class SideMenuViewController : UITableViewController {
  
  // MARK : - Property
  
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
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.SideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
    
    if indexPath.row == MenuType.Books.rawValue || indexPath.row == MenuType.Newsstand.rawValue || indexPath.row == MenuType.Docs.rawValue {
      cell.titleLabelLeadingConstraint.constant = 25
    } else {
      cell.titleLabelLeadingConstraint.constant = 15
    }
    
    if indexPath.row == MenuType.Search.rawValue || indexPath.row == MenuType.Sync.rawValue || indexPath.row == MenuType.Settings.rawValue {
      cell.menuIconImageView.isHidden = false
    }
    
    if indexPath.row == MenuType.Search.rawValue {
      cell.menuIconImageView.image = #imageLiteral(resourceName: "ic_search")
    } else if indexPath.row == MenuType.Sync.rawValue {
      cell.menuIconImageView.image = #imageLiteral(resourceName: "ic_synchronize")
    } else if indexPath.row == MenuType.Settings.rawValue {
      cell.menuIconImageView.image = #imageLiteral(resourceName: "ic_settings")
    }
    
    cell.titleLabel.text = Constants.MenuTitle[indexPath.row]
    
    return cell
  }

  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let mainViewController = sideMenuController!
    
    if indexPath.row == MenuType.Search.rawValue {
      
      // let viewController = UIViewController()
      // viewController.view.backgroundColor = .white
      // viewController.title = "Test \(titlesArray[indexPath.row])"
      
      let main = UIStoryboard.init(name: Constants.StorybordName.Main, bundle: nil)
      let searchBookVC = main.instantiateViewController(withIdentifier: "SearchBookVC") as! SearchBookViewController
      
      let navigationController = mainViewController.rootViewController as! UINavigationController
      navigationController.present(searchBookVC, animated: true, completion: nil)
      mainViewController.hideLeftView(animated: true, completionHandler: nil)

    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
