//
//  ViewController.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController

class ViewController: UIViewController {

  // 좋음 : 하트 , 보통 : 스마일, 나쁨 : 찡그림, 매우나쁨 : 악마
  
  // MARK : - Property 
  
  @IBOutlet weak var faceView: FaceView!
  let secondFace = FaceView()
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    faceView.lineWidth = 10
    
    secondFace.frame = CGRect(x: self.view.center.x - self.faceView.frame.size.width/2, y: 350, width: 160, height: 140)
    secondFace.backgroundColor = UIColor.white
    view.addSubview(secondFace)
    secondFace.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
  }

  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    
    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
      
      //print(self.faceView.frame)
      self.faceView.frame = CGRect(x: self.view.center.x - self.faceView.frame.size.width/2, y: 110, width: 160, height: 140)
      
      //print(self.faceView.frame)
    }, completion: nil)
    
    
    UIView.animate(withDuration: 0.7, animations: {
      self.secondFace.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }) { (finished) in
      
      UIView.animate(withDuration: 0.4, animations: {
        self.secondFace.transform = CGAffineTransform.identity
      })
    }
    

    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    faceView.frame = CGRect(x: self.view.center.x - self.faceView.frame.size.width/2, y: -200, width: 160, height: 140)
    //print(self.faceView.frame)
  }

}

