//
//  Constant.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 9. 4..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import UIKit

// MARK : - Constant 

struct Constant {
  
  // MARK : - Dummy Data
  
  struct DummyData {
    
    static let FirstTitle = "UIViewController is our root component"
    static let FirstDescription = "For typical applications that aren't games, you'll need to start with some kind of UIViewController component as the rootViewController of your app. \n\n\n\nUINavigationController, UITabBarController, UITableViewController, UICollectionViewController are all subclasses of UIViewController."
    static let SecondTitle = "why don't we just use UIViews?"
    static let Seconddescription = "UIViews can be used to present labels, images and whatnot so why don't we just use them directly? Well, technically this is totally possible but it'll make your life miserable when dealing with events such as Device Rotation or appearing and disappearing lifecycles."
    
    static let ThirdTitle = "Primary advantage is navigation "
    static let ThirdDescription = "When you need to go from one screen to the next screen, UINavigationController allows you to keep a stack of UIViewControllers so that you can go forwards and backwards by default. Furthermore, UIKit comes with UITabBarController that allows for multiple views on one screen that you can toggle through with a UITabBar of buttons. Building out your own controls that support this behavior yourself would be extremely time consuming and not worth the effort."
    static let FourthTitle = "Out of the box specialized UIViewControllers are all you need "
    static let FourthDescription = "A specialized controller I use for almost all my screens in an iOS application is UICollectionViewController. Some of you guys have already noticed this through many of my tutorials. Basically any page that requires a scrollable list should be built out with either a UITableViewController or UICollectionViewController. We often choose the latter because it comes with horizontal scrolling and it's much more customizable."
  }
  
  // MARK : - MainViewController
  
  struct MainVC {
    
    // MARK : - CollectionView Configuration Info
    
    struct CollectionViewConf {
      static let SectionInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0)
      static let ItemSpacing:CGFloat = 10
    }
    
    // MARK : - CollectionViewCell Configuration Info
    
    struct CollectionViewCellConf {
      static let CellCornerRadius:CGFloat = 4
      static let CellHeight:CGFloat = 140
      static let EnlargedCellTopMargin:CGFloat = 36
      static let EnlargedCellHeightMargin:CGFloat = 50
    }
    
    // MARK : - Description Lable Lines
    
    static let DefaultDescriptionLabelLine = 0
    static let AbbreviatedDescriptionLabelLine = 5
    
  }
  
  // MARK : - Cell Identifiers
  
  struct CellIDs {
    static let DescCollectionViewCell = "descriptionCollectionViewCell"
    static let DescCollectionViewHeader = "descriptionHeaderView"
  }
  
  // MARK : - Colors
  
  struct Colors {
    
    static let Skyblue = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    static let LightMagneta = UIColor(red: 147.0/255.0, green: 112.0/255.0, blue: 219.0/255.0, alpha: 0.6)
    static let Magneta = UIColor(red: 147.0/255.0, green: 112.0/255.0, blue: 219.0/255.0, alpha: 0.6)
    
  }
  
  // MARK : - Custom Error 
  
  struct CustomErrorMsg {
    static let UnexpectedHeaderTypeError = "Unexpected element kind"
  }
  
  
  
}
