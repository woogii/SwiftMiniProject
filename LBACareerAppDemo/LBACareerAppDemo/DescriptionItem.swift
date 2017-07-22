//
//  DescriptionItem.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 7. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - DescriptionItem

struct DescriptionItem {

  // MARK : - Property
  
  var title:String
  var description:String
  
  // MARK : - Initialization
  
  init(title:String, description:String) {
    self.title = title
    self.description = description
  }
  
  // MARK : - Get List of DescriptionItem 
  
  static func getListOfDescriptionItems()->[DescriptionItem] {
  
    return [DescriptionItem(title:"UIViewController is our root component",
                            description: "For typical applications that aren't games, you'll need to start with some kind of UIViewController component as the rootViewController of your app. \n\n\n\nUINavigationController, UITabBarController, UITableViewController, UICollectionViewController are all subclasses of UIViewController."),
            DescriptionItem(title:"why don't we just use UIViews?", description:"UIViews can be used to present labels, images and whatnot so why don't we just use them directly? Well, technically this is totally possible but it'll make your life miserable when dealing with events such as Device Rotation or appearing and disappearing lifecycles."),
            DescriptionItem(title:"Primary advantage is navigation ",description:"When you need to go from one screen to the next screen, UINavigationController allows you to keep a stack of UIViewControllers so that you can go forwards and backwards by default. Furthermore, UIKit comes with UITabBarController that allows for multiple views on one screen that you can toggle through with a UITabBar of buttons. Building out your own controls that support this behavior yourself would be extremely time consuming and not worth the effort."),
            DescriptionItem(title:"Out of the box specialized UIViewControllers are all you need ", description:"A specialized controller I use for almost all my screens in an iOS application is UICollectionViewController. Some of you guys have already noticed this through many of my tutorials. Basically any page that requires a scrollable list should be built out with either a UITableViewController or UICollectionViewController. We often choose the latter because it comes with horizontal scrolling and it's much more customizable.")]
  }
  
  
}
