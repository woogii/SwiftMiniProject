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
      adjustAutolayout(cell)
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
  
  fileprivate func adjustAutolayout(_ cell:SideMenuTableViewCell) {
    
    cell.contentView.translatesAutoresizingMaskIntoConstraints = false
    cell.titleLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
    cell.titleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 25).isActive = true
    cell.separatorView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
    cell.separatorView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
    cell.separatorView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
    cell.separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

  }
  
}
