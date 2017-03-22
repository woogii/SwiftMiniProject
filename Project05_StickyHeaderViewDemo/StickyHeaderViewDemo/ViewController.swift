//
//  ViewController.swift
//  StickyHeaderViewDemo
//
//  Created by TeamSlogup on 2017. 3. 14..
//  Copyright © 2017년 siwookhyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var upperImageView: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var favoriteImage: UIImageView!
  @IBOutlet weak var backImage: UIImageView!
  
  var initialY :CGFloat?
  var initProfileY:CGFloat?
  var initProfileX:CGFloat?
  var initFavoriteY:CGFloat?
  var initBackY:CGFloat?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  
    initialY = upperImageView.frame.origin.y
    
    initProfileY = profileImage.frame.origin.y
    initProfileX = profileImage.frame.origin.x
    initFavoriteY = favoriteImage.frame.origin.y
    initBackY = backImage.frame.origin.y
   
//    let button = UIButton(frame: CGRect(x:0,y:700,width:50,height:50))
//    button.setTitle("MoveToNextVC", for: .normal)
//    button.backgroundColor = UIColor.blue
//    button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
//    self.scrollView.addSubview(<#T##view: UIView##UIView#>)
  }


  func tapButton() {
    
    let viewController = UIViewController()
    
    self.present(viewController, animated: true, completion: nil)
  }

}

extension ViewController : UIScrollViewDelegate {
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    
    
      var modifiedFrame = upperImageView.frame
      var modifiedProfileFrame = profileImage.frame
    
      var modifiedFavoriteFrame = favoriteImage.frame
      var modifiedBackFrame =  backImage.frame
    
      print("scrollView offset y : \(scrollView.contentOffset.y)")
      modifiedFrame.origin.y = max(initialY!, scrollView.contentOffset.y - 160)
    
      modifiedProfileFrame.origin.y = max(initProfileY!, scrollView.contentOffset.y + 10)
    
  
      modifiedProfileFrame.origin.x = min(max(initProfileX!, scrollView.contentOffset.y - 40), initProfileX! + 40)
    
      
    
    
    
    
      modifiedFavoriteFrame.origin.y = max(initFavoriteY!, scrollView.contentOffset.y + 10)
      modifiedBackFrame.origin.y =  max(initBackY!, scrollView.contentOffset.y + 10 )
    
      upperImageView.frame = modifiedFrame
      profileImage.frame = modifiedProfileFrame
      favoriteImage.frame =  modifiedFavoriteFrame
      backImage.frame  = modifiedBackFrame
    }
  
  
}
