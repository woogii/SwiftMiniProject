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
  
  @IBOutlet weak var textFieldContainerView: UIView!
  @IBOutlet weak var tagListCollectionView: UICollectionView!
  @IBOutlet weak var tagFlowLayout: TagFlowLayout!
  @IBOutlet weak var tagCollectionViewHeightConstant: NSLayoutConstraint!
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var confirmButton: UIButton!
  
  fileprivate var tagList = [String]()
  fileprivate var sizingCell: TagCollectionViewCell?
    
  
  // MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    configureCollectionViewCellNib()
    setFlowlayoutSectionInset()
    setCollectionViewLayout()
    configureConfirmButton()
    setInitialCollectionViewHeightConstraint()
    configureTextFieldContainerView()
  }
  
  private func setInitialCollectionViewHeightConstraint() {
    tagCollectionViewHeightConstant.constant = 0
  }
  
  private func configureTextFieldContainerView() {
    textFieldContainerView.layer.borderColor = UIColor.lightGray.cgColor
    textFieldContainerView.layer.borderWidth = Constants.BoderWidth
  }
  
  private func setCollectionViewLayout() {
    tagListCollectionView.collectionViewLayout = tagFlowLayout
  }
  
  private func configureConfirmButton() {
    confirmButton.layer.cornerRadius = confirmButton.frame.height/2
  }
  
  private func configureCollectionViewCellNib() {
    
    let cellNib = UINib(nibName: Constants.TagCollectionViewCellFileName , bundle: nil)
    
    tagListCollectionView.register(cellNib, forCellWithReuseIdentifier: Constants.TagCollectionViewCellIdentifier)
    tagListCollectionView.backgroundColor = UIColor.clear
    sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCollectionViewCell?
  }
  
  private func setFlowlayoutSectionInset()
  {
    tagFlowLayout.sectionInset = UIEdgeInsets.zero
  }
}

// MARK : - ViewController: UITextFieldDelegate

extension ViewController : UITextFieldDelegate {
  
  // MARK : - UITextFieldDelegate Method 
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    view.endEditing(true)
    
    if textField.text == ""  {
      return false
    } else {
      
      guard let enteredText = textField.text else { return false }
      
      
      if validateEnteredText(enteredText) {
        tagList.append(enteredText)
        adjustHeightConstraint(of: tagListCollectionView)
        textField.text = ""
      } else {
        return false
      }
    }
    return true
  }
  
  fileprivate func validateEnteredText(_ enteredText:String)->Bool {
    
    if enteredText.characters.count > Constants.MaximumKeywordCount {
      let alertController = UIAlertController(title: "", message: Constants.KeywordValidationErrorMessage, preferredStyle: .alert)
      let okAction = UIAlertAction(title: Constants.OkButtonTitle, style: .destructive, handler: nil)
      alertController.addAction(okAction)
      present(alertController, animated: true, completion: nil)
      
      return false
    } else {
      return true
    }
  }

  
  
}


// MARK : - ViewController: UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    guard let cell = sizingCell else {
      return CGSize()
    }
    
    configureCell(cell: cell, forIndexPath: indexPath)
    return cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)  // The option to use the smallest possible size
  }
}

// MARK : - ViewController: UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
  
  // MARK : - UICollectionViewDataSource Methods 
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tagList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = tagListCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.TagCollectionViewCellIdentifier, for: indexPath) as! TagCollectionViewCell
    configureCell(cell: cell, forIndexPath: indexPath)
    return cell
  }
  
  // MARK : - Configure TagCollectionViewCell
  
  fileprivate func configureCell(cell: TagCollectionViewCell, forIndexPath indexPath: IndexPath) {
    
    let keyword = tagList[indexPath.item]
    cell.keywordLabel.text = keyword
    cell.closeButton.tag = indexPath.item
    
    cell.closeButton.addTarget(self, action: #selector(ViewController.pushTagButton(sender:)), for: .touchUpInside)
  }
  
  func pushTagButton(sender:UIButton) {
    
    // Remove the selected tag
    tagList.remove(at: sender.tag)
    adjustHeightConstraint(of: tagListCollectionView)
  }
  
  fileprivate func adjustHeightConstraint(of collectionView : UICollectionView) {
    collectionView.reloadData()
    
    UIView.animate(withDuration: 1.0, animations: {
      
      self.tagCollectionViewHeightConstant.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
      
    })
    self.view.layoutIfNeeded()
  }
  
}

