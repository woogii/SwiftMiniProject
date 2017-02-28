//
//  ViewController.swift
//  Project04_CommentSystem
//
//  Created by TeamSlogup on 2016. 10. 10..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let blurView = UIView(frame: (87,304,200,100) )
        let blurView = UIView(frame: CGRect(x: 87, y: 304, width: 200, height: 100))
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(blurView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

