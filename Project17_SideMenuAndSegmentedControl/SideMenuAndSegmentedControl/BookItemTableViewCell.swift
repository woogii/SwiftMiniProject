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
  @IBOutlet var downloadIndicatorImageView: UIImageView!
  @IBOutlet var circleViews:[UIView]!
  
  var bookItemInfo : Book! {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    titleLabel.text = bookItemInfo.title
    authorLabel.text = bookItemInfo.author
    fetchBookCoverImageUrl(isbn:bookItemInfo.isbn)
  
  }
  
  func fetchBookCoverImageUrl(isbn:String) {
    
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
        
        print(smallThumbnailUrl)
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
    
    addCustomSelectedBackgroundView()
    setCornerRadiusForCircleViews()
  }
  
  func addCustomSelectedBackgroundView() {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    selectedBackgroundView = view
    
  }
  
  func setCornerRadiusForCircleViews() {
    for view in circleViews {
      view.layer.cornerRadius = view.frame.size.width/2
    }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    let color = circleViews[0].backgroundColor
    super.setSelected(selected, animated: animated)
    for view in circleViews {
      view.backgroundColor = color
    }
  }
  
  
  
}
