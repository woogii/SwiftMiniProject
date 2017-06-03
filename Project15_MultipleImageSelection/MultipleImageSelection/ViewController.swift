//
//  ViewController.swift
//  MultipleImageSelection
//
//  Created by siwook on 2017. 6. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let menuTitle = ["Location","Website","Birthday"]
  let menuDescription = ["Seoul, Korea","http://woogii.devport.co/","2016-09-25"]
  let cellIdentifier = "cell"
  @IBOutlet weak var bioTextView: UITextView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var upperView: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bioTextView.textContainerInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 0.0, right: 0.0)
    
  }

  


}


extension ViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuTitle.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileInfoCell
    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }
  
  func configureCell(cell:ProfileInfoCell, indexPath:IndexPath) {
    cell.titleLabel.text = menuTitle[indexPath.row]
    cell.descriptionLabel.text = menuDescription[indexPath.row]
  }
}
