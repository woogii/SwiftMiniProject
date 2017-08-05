//
//  ViewController.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // 좋음 : 하트 , 보통 : 스마일, 나쁨 : 찡그림, 매우나쁨 : 악마
  @IBOutlet weak var faceView: FaceView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    faceView.lineWidth = 10
    
    
  }

  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    
    UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
      
      //print(self.faceView.frame)
      self.faceView.frame = CGRect(x: self.view.center.x - self.faceView.frame.size.width/2, y: 110, width: 160, height: 140)
      
      //print(self.faceView.frame)
    }, completion: nil)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    faceView.frame = CGRect(x: self.view.center.x - self.faceView.frame.size.width/2, y: -200, width: 160, height: 140)
    //print(self.faceView.frame)
  }

}

