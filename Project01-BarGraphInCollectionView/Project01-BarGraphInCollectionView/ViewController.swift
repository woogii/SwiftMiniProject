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
    
    @IBOutlet weak var pageControl: UIPageControl!
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
        configurePageControl()
        
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        } else {
            // Fallback on earlier versions
        }

    }
    
    
    func configurePageControl() {
        pageControl.backgroundColor = UIColor.clear
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.numberOfPages = ratioValueToMax.count
    }

}

// MARK : - ViewController: UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
    
    // MARK : - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ratioValueToMax.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BarGraphCollectionViewCell
        
        print("indexPath : \(indexPath.item)")
        cell.contentView.frame = cell.bounds
        
        removeGradientLayersFromValueBarGraphs(cell)
        initializeValueBarGraphsHeightConstraints(cell)
        configureGradientLayersForValueGraphs(cell)
        addGradientLayersForValueGraphs(cell)
        animateValues(cell, atIndexPath: indexPath)

        
        
        
        return cell
    }
    
    func initializeValueBarGraphsHeightConstraints(_ cell:BarGraphCollectionViewCell) {
        cell.redValueViewHeightConstraint.constant = 0.0
        cell.greenValueViewHeightConstraint.constant = 0.0
        cell.blueValueViewHeightConstraint.constant = 0.0
    }
    
    func removeGradientLayersFromValueBarGraphs(_ cell:BarGraphCollectionViewCell) {
        
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
    
    func configureGradientLayersForValueGraphs(_ cell : BarGraphCollectionViewCell) {
        
        cell.redBarGradientLayer.colors = [redColors[0].cgColor, redColors[1].cgColor]
        cell.redBarGradientLayer.locations = [0.0, 1.0]
        cell.redBarGradientLayer.frame =  cell.redBackgroundView.layer.bounds
        cell.redBarGradientLayer.masksToBounds = true
        
        cell.greenBarGradientLayer.colors = [greenColors[0].cgColor, greenColors[1].cgColor]
        cell.greenBarGradientLayer.locations = [0.0, 1.0]
        cell.greenBarGradientLayer.frame = cell.greenBackgroundView.layer.bounds
        cell.greenBarGradientLayer.masksToBounds = true
        
        
        cell.blueBarGradientLayer.colors = [blueColors[0].cgColor, blueColors[1].cgColor]
        cell.blueBarGradientLayer.locations = [0.0, 1.0]
        cell.blueBarGradientLayer.frame = cell.blueBackgroundView.layer.bounds
        cell.blueBarGradientLayer.masksToBounds = true
        
    }
    
    func addGradientLayersForValueGraphs(_ cell : BarGraphCollectionViewCell) {
        
        cell.redValueView.layer.addSublayer(cell.redBarGradientLayer)
        cell.greenValueView.layer.addSublayer(cell.greenBarGradientLayer)
        cell.blueValueView.layer.addSublayer(cell.blueBarGradientLayer)
        
    }
    
    func animateValues(_ cell : BarGraphCollectionViewCell, atIndexPath indexPath: IndexPath) {
        
        let delay:Double = 0.1
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time){
            
            UIView.animate(withDuration: 0.8, animations: {
                cell.redValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[(indexPath as NSIndexPath).row][0] * self.cellBackgroundHeight )
                cell.greenValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[(indexPath as NSIndexPath).row][1] * self.cellBackgroundHeight )
                cell.blueValueViewHeightConstraint.constant = CGFloat( self.ratioValueToMax[(indexPath as NSIndexPath).row][2] * self.cellBackgroundHeight )
                
                cell.layoutIfNeeded()
            })
        }

        
        
    }
    
    
}

// MARK : - ViewController: UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}

// MARK : - ViewController: UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = collectionView.frame.size.width
        pageControl.currentPage  = Int(floor((collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
    }
    
}
