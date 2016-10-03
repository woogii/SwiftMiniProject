//
//  TagCollectionViewCell.swift
//  Project03-TagListCollectionViewCell
//
//  Created by TeamSlogup on 2016. 10. 3..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - TagCollectionViewCell : UICollectionViewCell

class TagCollectionViewCell: UICollectionViewCell {
    
    // MARK : - Property
    
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewMaxWidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK : - Nib file loading
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        containerView.backgroundColor = UIColor(colorLiteralRed: 111.0/255.0, green: 134.0/255.0, blue: 144.0/255.0, alpha: 0.1)
        containerView.layer.cornerRadius = 15
        containerViewMaxWidhtConstraint.constant = UIScreen.main.bounds.width
    }

}
