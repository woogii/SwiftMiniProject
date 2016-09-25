//
//  ViewController.swift
//  Project01-BarGraphInCollectionView
//
//  Created by TeamSlogup on 2016. 9. 25..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController

class ViewController: UIViewController {
    
    
    // MARK : - Property
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "barGraphCollectionViewCell"
    let ratioValueToMax:[[Float]] = [[0.6,0.7,0.8],[0.3,0.5,0.5],[0.6,0.8,0.4],[0.7,0.2,0.6],[0.6,0.3,0.2]]
    let cellBackgroundHeight:Float = 221.0
    
    let redColors = [UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0),UIColor(red: 255.0/255.0, green: 68.0/255.0, blue: 0.0/255.0, alpha: 1.0)]
    let greenColors = [UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0),UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 80.0/255.0, alpha: 1.0)]
    let blueColors = [UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1.0),UIColor(red: 0.0/255.0, green: 85.0/255.0, blue: 0.0/255.0, alpha: 1.0)]
    
    // MARK : - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}

// MARK : - ViewController: UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
    
    // MARK : - Collection view data source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ratioValueToMax.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! BarGraphCollectionViewCell
        cell.contentView.frame = cell.bounds
        
        removeGradientLayersFromValueBarGraphs(cell)
        initializeValueBarGraphsHeightConstraints(cell)
        configureGradientLayersForValueGraphs(cell)
        addGradientLayersForValueGraphs(cell)
        animateValues(cell, atIndexPath: indexPath)

        
        
        
        return cell
    }
    
    func initializeValueBarGraphsHeightConstraints(cell:BarGraphCollectionViewCell) {
        cell.redValueViewHeightConstraint.constant = 0.0
        cell.greenValueViewHeightConstraint.constant = 0.0
        cell.blueValueViewHeightConstraint.constant = 0.0
    }
    
    func removeGradientLayersFromValueBarGraphs(cell:BarGraphCollectionViewCell) {
        
        if let _ = cell.redValueView.layer.sublayers {
            cell.redBarGradientLayer.removeFromSuperlayer()
        }
        
        if let _ = cell.greenValueView.layer.sublayers {
            cell.redBarGradientLayer.removeFromSuperlayer()
        }
        
        if let _ = cell.blueValueView.layer.sublayers {
            cell.blueBarGradientLayer.removeFromSuperlayer()
        }
        
    }
    
    func configureGradientLayersForValueGraphs(cell : BarGraphCollectionViewCell) {
        
        cell.redBarGradientLayer.colors = [redColors[0].CGColor, redColors[1].CGColor]
        cell.redBarGradientLayer.locations = [0.0, 1.0]
        cell.redBarGradientLayer.frame =  cell.redBackgroundView.layer.bounds
        cell.redBarGradientLayer.masksToBounds = true
        
        cell.greenBarGradientLayer.colors = [greenColors[0].CGColor, greenColors[1].CGColor]
        cell.greenBarGradientLayer.locations = [0.0, 1.0]
        cell.greenBarGradientLayer.frame = cell.greenBackgroundView.layer.bounds
        cell.greenBarGradientLayer.masksToBounds = true
        
        
        cell.blueBarGradientLayer.colors = [blueColors[0].CGColor, blueColors[1].CGColor]
        cell.blueBarGradientLayer.locations = [0.0, 1.0]
        cell.blueBarGradientLayer.frame = cell.blueBackgroundView.layer.bounds
        cell.blueBarGradientLayer.masksToBounds = true
        
    }
    
    func addGradientLayersForValueGraphs(cell : BarGraphCollectionViewCell) {
        
        cell.redValueView.layer.addSublayer(cell.redBarGradientLayer)
        cell.greenValueView.layer.addSublayer(cell.greenBarGradientLayer)
        cell.blueValueView.layer.addSublayer(cell.blueBarGradientLayer)
        
    }
    
    func animateValues(cell : BarGraphCollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let delay:Double = 0.1
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(delay * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()){
            
            UIView.animateWithDuration(0.8, animations: {
                cell.redValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[indexPath.row][0] * self.cellBackgroundHeight )
                cell.greenValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[indexPath.row][1] * self.cellBackgroundHeight )
                cell.blueValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[indexPath.row][2] * self.cellBackgroundHeight )
                
                cell.layoutIfNeeded()
            })
        }

        
        
    }
    
    
}

// MARK : - ViewController: UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
}