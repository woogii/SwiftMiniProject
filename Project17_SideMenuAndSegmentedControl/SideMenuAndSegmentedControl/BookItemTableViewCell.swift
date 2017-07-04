//
//  BookItemTableViewCell.swift
//  SideMenuAndSegmentedControl
//
//  Created by siwook on 2017. 6. 30..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage

// MARK : - BookItemTableViewCell: UITableViewCell

class BookItemTableViewCell: UITableViewCell {
  
  // MARK : - Property
  
  @IBOutlet weak var bookCoverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var downloadIndicatorImageView: UIImageView!
  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  @IBOutlet weak var view4: UIView!
  @IBOutlet weak var view5: UIView!
  @IBOutlet weak var view6: UIView!
  @IBOutlet weak var view7: UIView!
  @IBOutlet weak var view8: UIView!
  @IBOutlet weak var view9: UIView!
  @IBOutlet weak var view10: UIView!
  @IBOutlet weak var view11: UIView!
  @IBOutlet weak var view12: UIView!
  @IBOutlet weak var view13: UIView!
  @IBOutlet weak var view14: UIView!
  @IBOutlet weak var view15: UIView!
  @IBOutlet weak var view16: UIView!
  @IBOutlet weak var view17: UIView!
  @IBOutlet weak var view18: UIView!
  var circleViews:[UIView] = [UIView]()
  
  var bookItemInfo : Book! {
    didSet {
      updateUI()
    }
  }
  
  // MARK : - Update Cell UI 
  
  private func updateUI() {
    setCircleViews()
    titleLabel.text = bookItemInfo.title
    authorLabel.text = bookItemInfo.author
    fetchBookCoverImageUrl(isbn:bookItemInfo.isbn)
  }
  
  private func setCircleViews() {
  
    if bookItemInfo.isDownloaded == false {
      setCircleViewsHiddenStatus(true)
      downloadIndicatorImageView.isHidden = true
    } else {
      
      downloadIndicatorImageView.isHidden = false
      downloadIndicatorImageView.image = #imageLiteral(resourceName: "ic_checked")
      setCircleViewsHiddenStatus(false)
    
      let numberOfAmountRead = (Double)(bookItemInfo.lastPageRead)/(Double)(bookItemInfo.totalPage)
      let numberOfColoredCircle = Int(numberOfAmountRead * Double(circleViews.count))
      
      displayCircleViews(numberOfColoredCircle)
      
    }
  }
  
  private func displayCircleViews(_ numberOfColoredCircle:Int) {
  
    for i in 0..<numberOfColoredCircle {
      circleViews[i].backgroundColor = UIColor.blue
    }
    
    for i in numberOfColoredCircle..<circleViews.count {
      circleViews[i].backgroundColor = UIColor.white
    }
    
  }
  
  private func setCircleViewsHiddenStatus(_ isHidden:Bool) {
    
    for view in circleViews {
      view.isHidden = isHidden
    }
  }
  
  
  
  private func fetchBookCoverImageUrl(isbn:String) {
    
    let sharedSession = URLSession.shared
    let finalUrl = Constants.GoogleBookAPI.BaseUrl + isbn
    
    guard let bookURL = URL(string: finalUrl) else {
      return
    }
    
    sharedSession.dataTask(with: bookURL) { (data, response, error) in
      
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      
      guard let data = data else {
        return
      }
      
      do {
        
        guard let jsonDictArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {
          return
        }
        
        guard let dictArray = jsonDictArray[Constants.GoogleBookAPI.JSONResponseKeys.Items] as? [[String:Any]] else {
          return
        }
        
        guard let volumeInfoDict = dictArray[0][Constants.GoogleBookAPI.JSONResponseKeys.VolumeInfo] as? [String:Any] else {
          return
        }
        
        guard let coverImageInfoDict = volumeInfoDict[Constants.GoogleBookAPI.JSONResponseKeys.ImageLinks] as? [String:Any] else {
          return
        }
        
        guard let smallThumbnailUrl = coverImageInfoDict[Constants.GoogleBookAPI.JSONResponseKeys.SmallThumbnail] as? String else {
          return
        }
        
        
        self.bookCoverImageView.sd_setImage(with: URL(string:smallThumbnailUrl)!, placeholderImage: UIImage(named:""), options: SDWebImageOptions(), completed: { (image, error, cacheType, url) in
          
          if image != nil {
            DispatchQueue.main.async {
              self.bookCoverImageView.image = image
            }
          }
        })
      } catch let error {
        print(error.localizedDescription)
      }
      
    }.resume()
    
  }
  
  // MARK : - Nib file loading
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    initCircleViewArray()
    addCustomSelectedBackgroundView()
    setCornerRadiusForCircleViews()
  
  }
  
  private func initCircleViewArray() {
    circleViews = [view1,view2,view3,view4,view5,view6,view7,view8,view9,view10,
                   view11,view12,view13,view14,view15,view16,view17,view18]
  }
  
  private func addCustomSelectedBackgroundView() {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    selectedBackgroundView = view
    
  }
  
  private func setCornerRadiusForCircleViews() {
    
    for view in circleViews {
      view.layer.cornerRadius = view1.frame.size.width/2
    }
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    var colors = [UIColor]()
    
    for i in 0..<circleViews.count {
      if let color = circleViews[i].backgroundColor {
        colors.append(color)
      }
    }
    
    super.setSelected(selected, animated: animated)
    
    for i in 0..<circleViews.count {
      circleViews[i].backgroundColor = colors[i]
    }
  }
  
  
  
}
