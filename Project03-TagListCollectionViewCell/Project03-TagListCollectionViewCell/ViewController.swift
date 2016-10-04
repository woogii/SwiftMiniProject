//
//  ViewController.swift
//  Project03-TagListCollectionViewCell
//
//  Created by TeamSlogup on 2016. 10. 3..
//  Copyright © 2016년 siwookhyun. All rights reserved.
//

import UIKit

// MARK : - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK : - Property 
    
    @IBOutlet weak var tagListCollectionView: UICollectionView!
    
    var tagList = [String]()
    let tagCollectionViewCellIdentifier = "tagCollectionViewCell"
    let tagCollectionViewCellFileName = "TagCollectionViewCell"
    var sizingCell: TagCollectionViewCell?
    @IBOutlet weak var tagFlowLayout: TagFlowLayout!
    @IBOutlet weak var tagCollectionViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    
    // MARK : - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureCollectionViewCellNib()
        setFlowlayoutSectionInset()
        tagListCollectionView.collectionViewLayout = tagFlowLayout
    }

    
    func configureCollectionViewCellNib() {
        
        let cellNib = UINib(nibName: tagCollectionViewCellFileName , bundle: nil)
        
        tagListCollectionView.register(cellNib, forCellWithReuseIdentifier: tagCollectionViewCellIdentifier)
        tagListCollectionView.backgroundColor = UIColor.clear
        
        // instantiateWithOwner: Unarchives and instantiates the in-memory contents of the receiver’s nib file, creating a distinct object tree and set of top level objects.
        sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCollectionViewCell?
        
    }
    
    func setFlowlayoutSectionInset()
    {
        tagFlowLayout.sectionInset = UIEdgeInsets.zero
    }
}

// MARK : - ViewController: UITextFieldDelegate

extension ViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        
        if textField.text == ""  {
            return false
        } else {
            
            tagList.append(textField.text!)
            collectionViewReloadAndAdjustHeightConstraint(collectionView: tagListCollectionView)
            textField.text = ""
        }
        
        return true
    }

}


// MARK : - ViewController: UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        configureCell(cell: sizingCell!, forIndexPath: indexPath)
        return sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)  // The option to use the smallest possible size
    }
}

// MARK : - ViewController: UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = tagListCollectionView.dequeueReusableCell(withReuseIdentifier: tagCollectionViewCellIdentifier, for: indexPath) as! TagCollectionViewCell
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: TagCollectionViewCell, forIndexPath indexPath: IndexPath) {
        
        let keyword = tagList[indexPath.item]
        cell.keywordLabel.text = keyword
        cell.closeButton.tag = indexPath.item
    
        cell.closeButton.addTarget(self, action: #selector(ViewController.pushTagButton(sender:)), for: .touchUpInside)
    }
    
    func pushTagButton(sender:UIButton) {
        
        // 선택된 버튼 삭제
        tagList.remove(at: sender.tag)
        collectionViewReloadAndAdjustConstraintAfterDelete(collectionView: tagListCollectionView)
        
    }
    
    func collectionViewReloadAndAdjustHeightConstraint(collectionView : UICollectionView) {
        collectionView.reloadData()
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.tagCollectionViewHeightConstant.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
            
        })
        self.view.layoutIfNeeded()
    }
    
    func collectionViewReloadAndAdjustConstraintAfterDelete(collectionView : UICollectionView) {
        
        // keyword 가 있을 경우에만 collectionView height constraint 조정. keyword 가 삭제될 경우 collectionView Height 를 처음 화면 진입 상태 그대로 유지
        collectionView.reloadData()
        if tagList.count > 0 {
            
            UIView.animate(withDuration: 1.0, animations: {
                
                self.tagCollectionViewHeightConstant.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
                
            })
        }
        
        self.view.layoutIfNeeded()
        
        
        
    }


}

