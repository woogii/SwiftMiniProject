//
//  SplashViewController.swift
//  UIViewAnimation
//
//  Created by siwook on 2017. 8. 6..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit


// MARK : - SplashViewController: UIViewController

class SplashViewController: UIViewController {

  // MARK : - Property 
  
  @IBOutlet weak var loadingIndicatorLabel: UILabel!
  let segueID = "showPollutantInfoVC"
  var dustInfoList = [DustInfo]()
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadingIndicatorLabel.startBlink()
    fetchDustInformation()
  }

  func test() {
    
    let when = DispatchTime.now() + 2 
    DispatchQueue.main.asyncAfter(deadline: when) {
      self.performSegue(withIdentifier: self.segueID, sender: self)
      self.loadingIndicatorLabel.stopBlink()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func fetchDustInformation() {
    
    guard let filePath = Bundle.main.url(forResource: "DustInfoJson", withExtension: "json") else {
      print("Cannot find the url of the file")
      return
    }
    
    do {
      let jsonData = try Data(contentsOf: filePath)
      
      guard let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String:Any]] else {
        print("Serialization error")
        return
      }
      
      self.dustInfoList = jsonResult.flatMap({ dustInfoDict -> DustInfo? in
        return DustInfo(dictionary: dustInfoDict)
      })
      
      
      DispatchQueue.main.async {
        self.performSegue(withIdentifier: self.segueID, sender: self)
      }
      
      
      
    } catch let error {
      print(error)
    }

  }
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! PollutantInfoViewController
    
    destinationVC.dustInfoList = dustInfoList
  }
  
 }


extension UILabel {
  
  func startBlink() {
    UIView.animate(withDuration: 0.8,
                   delay:0.0,
                   options:[.autoreverse, .repeat],
                   animations: {
                    self.alpha = 0
    }, completion: nil)
  }
  
  func stopBlink() {
    alpha = 1
    layer.removeAllAnimations()
  }
}
