//
//  SlideInMenu.swift
//  SlideInMenu
//
//  Created by siwook on 2017. 5. 21..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit



// MARK : - SlideInMenu : NSObject

class SlideInMenu : NSObject {
  
  // MARK : - Property
  
  let opaqueView : UIView = {
    let opaqueView = UIView()
    opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return opaqueView
  }()
  fileprivate let iconImageList = ["Desc","Desc","Desc"]
  fileprivate let title = ["Sort by Vote","Sort by Title", "Sort by Date"]
  fileprivate let type = ["Asedning, Descending"]
  let nibFileName = "SlideMenuCollectionViewCell"
  let cellId = "slideMenuCollectionViewCell"
  let cellHeight:CGFloat = 70
  var menuInfoList = [MenuInfo]()
  fileprivate let collectionView : UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame:.zero, collectionViewLayout:flowLayout)
    collectionView.backgroundColor = UIColor.white
    return collectionView
  }()
  fileprivate var menuCell:SlideMenuCollectionViewCell!
  var postListVC:PostListViewController?
  fileprivate var collectionViewFrame:CGRect!
  fileprivate enum SortType : Int{
    case vote = 0
    case title
    case date
  }
  
  // MARK : - View Life Cycle
  
  override init() {
    
    super.init()
    
    initMenuInfoList()
    configureCollectionView()
    addTapGestureToOpaqueView()
  }
  
  func addTapGestureToOpaqueView() {
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOpaqueView))
    gesture.numberOfTapsRequired = 1
    opaqueView.addGestureRecognizer(gesture)

  }
  
  func initMenuInfoList() {
    
    for i in 0..<iconImageList.count {
      let menu = MenuInfo(iconImageName: iconImageList[i], title: title[i])
      menuInfoList.append(menu)
    }
  }
  
  func configureCollectionView() {
    
    setDelegate()
    setDataSource()
    registerNibAndInstantiateCollectionViewCell()
    
  }
  
  func setDelegate() {
    collectionView.delegate = self
  }
  
  func setDataSource() {
    collectionView.dataSource = self
  }
  
  func registerNibAndInstantiateCollectionViewCell() {
    
    let nib = UINib(nibName: nibFileName, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    menuCell = nib.instantiate(withOwner: nil, options: nil)[0] as! SlideMenuCollectionViewCell
  }
  
  func tapOpaqueView() {
    if let window = UIApplication.shared.keyWindow {
      slideOutMenu(to:window)
    }
  }
  
  func showMenu() {
    
    if let window = UIApplication.shared.keyWindow {
      
      addSlideMenuSubViews(to: window)
      setCollectionViewFrame(window: window)
      setOpaqueViewFrame(in:window)
      
      UIView.animate(withDuration: 0.3, animations: {
        self.slideInMenu(to:window)
      }, completion: nil)
    }
    
  }

  func addSlideMenuSubViews(to window :UIWindow) {
    window.addSubview(opaqueView)
    window.addSubview(collectionView)
  }
  
  
  func setOpaqueViewFrame(in window:UIWindow) {
    self.opaqueView.frame = window.frame
    self.opaqueView.alpha = 0.0

  }
  
  func slideInMenu(to window:UIWindow) {
    self.opaqueView.alpha = 1.0
    self.collectionView.frame = CGRect(x: 0, y: window.frame.height - self.collectionViewFrame.height, width: self.collectionViewFrame.width, height: self.collectionViewFrame.height)
  }

  func slideOutMenu(to window:UIWindow) {
    
    self.opaqueView.alpha = 0.0
    UIView.animate(withDuration: 0.3, animations: {
      
      self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionViewFrame.width, height: self.collectionViewFrame.height)
    }, completion: nil)

  }

  
  func setCollectionViewFrame(window:UIWindow) {
    
    let collectionViewHeight = cellHeight * (CGFloat)(menuInfoList.count)
    collectionViewFrame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height:collectionViewHeight)
    collectionView.frame = collectionViewFrame
    
  }
}


// MARK : - SlideInMenu : UICollectionViewDelegate, UICollectionViewDataSource

extension SlideInMenu : UICollectionViewDelegate, UICollectionViewDataSource {
  
  // MARK : - UICollectionView DataSource Methods
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return menuInfoList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SlideMenuCollectionViewCell
    
    let menuInfo = menuInfoList[indexPath.item]
    
    cell.iconImageView.image = UIImage(named:menuInfo.iconImageName) ?? UIImage()
    cell.typeLabel.text = menuInfo.title
    
    return cell
  }
  
  // MARK : - UICollectionView Delegate
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if let window = UIApplication.shared.keyWindow {
      UIView.animate(withDuration: 0.3, animations: {
        self.slideOutMenu(to: window)
      }, completion: nil)
    }
  
    performSort(index: indexPath.item)
  }
  
  func performSort(index:Int) {
  
    switch index {
      
    case SortType.vote.rawValue :
      
      if let sortedPostList = postListVC?.postList.sorted(by: {
        return $0.upvoteCount > $1.upvoteCount
      }) {
        postListVC?.postList = sortedPostList
      }
      break
    case SortType.title.rawValue :
      if let sortedPostList = postListVC?.postList.sorted(by: {
        return $0.title > $1.title
      })
      {
        postListVC?.postList = sortedPostList
      }
      break
    default:
      if let sortedPostList = postListVC?.postList.sorted(by: {
        return $0.postingDate > $1.postingDate
      })
      {
        postListVC?.postList = sortedPostList
      }
      break
    }
    
    DispatchQueue.main.async {
      self.postListVC?.tableView.reloadData()
    }

    
  }
}

// MARK : - SlideInMenu : UICollectionViewDelegateFlowLayout

extension SlideInMenu : UICollectionViewDelegateFlowLayout {
  
  // MARK : - UICollectionViewDelegateFlowLayout Method
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
}
