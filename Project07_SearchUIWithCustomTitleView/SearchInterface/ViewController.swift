//
//  ViewController.swift
//  SearchInterface
//
//  Created by siwook on 2017. 4. 3..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - ViewController : UIViewController

class ViewController: UIViewController {
  
  // MARK : - Property
    
  @IBOutlet weak var textView: UITextView!
  let searchView = SearchKeywordContainerView.instanceFromNib()
  let customViewNibName = "SearchKeywordContainerView"
  let cellIdentifier = "searchKeywordCollectionViewCell"
  let cellNibFileName = "SearchKeywordCollectionViewCell"
  let keywordInputVCStoryboardID = "keywordInputVC"
  let mainStoryboard = "Main"
  var keywordString = ""
  var keywordList = [String]()
  var sizingCell:SearchKeywordCollectionViewCell?
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    addTargetForClearButton()
    configureNavigationBar()
    configureSearchTagCollectionView()
    addTapGestureToSearchView()
    setDelegateAndDatasource()
  
  }

  func addTargetForClearButton() {
    searchView.clearButton.addTarget(self, action: #selector(clearKeywordInputUI), for: .touchUpInside)
  }
  
  func clearKeywordInputUI() {
    
    clearKeywordList()
    setSearchKeyword(searchKeyword: "")
    displayKeywordStringInTextView(searchKeyword: "")
    
    DispatchQueue.main.async {
      self.searchView.keywordCollectionView.reloadData()
      self.displaySearchContainerSubViews(isKeywordExist: false)
     
    }
  }

  fileprivate func configureSearchTagCollectionView() {
    
    let cellNib = UINib(nibName: cellNibFileName, bundle: nil)
    sizingCell = (cellNib.instantiate(withOwner: nil, options: nil)[0] as! SearchKeywordCollectionViewCell)
    
    searchView.keywordCollectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    searchView.keywordCollectionView.backgroundColor = UIColor.clear
  }
  
  fileprivate func configureNavigationBar() {
    
    navigationItem.titleView = searchView
    navigationItem.titleView?.sizeToFit()
    searchView.clearButton.isHidden = true
    navigationController?.navigationBar.barTintColor = UIColor(red: 101.0/255.0, green: 158.0/255.0, blue: 199.0/255.0, alpha: 0.4)
      
  }
  
  fileprivate func addTapGestureToSearchView() {
    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(ViewController.serchViewTapped(_:)))
    searchView.isUserInteractionEnabled = true
    searchView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  fileprivate func setDelegateAndDatasource() {
    searchView.keywordCollectionView.delegate = self
    searchView.keywordCollectionView.dataSource = self
  }
  
  func serchViewTapped(_ view:UIView) {
    
    let storyboard = UIStoryboard(name: mainStoryboard, bundle: nil)
    let destinationVC = storyboard.instantiateViewController(withIdentifier: keywordInputVCStoryboardID) as! KeywordInputViewController
    destinationVC.delegate = self
    destinationVC.keywordString = keywordString
    
    navigationController?.pushViewController(destinationVC, animated: true)
    
  }
  
  
  // MARK : - Collection view item size
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    
    guard let sizingCell = self.sizingCell else {
      return CGSize(width: 0.0, height: 0.0)
    }
    
    self.configureSearchTagCollectionViewCell(sizingCell, indexPath: indexPath)
    
    return sizingCell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
  }
  
  func configureSearchTagCollectionViewCell(_ cell:SearchKeywordCollectionViewCell, indexPath: IndexPath) {
    cell.keywordLabel.text = keywordList[indexPath.item]
  }
  
  func displaySearchContainerSubViews(isKeywordExist:Bool) {
    
    searchView.clearButton.isHidden = !isKeywordExist
    searchView.placeHolderLabel.isHidden = isKeywordExist
    searchView.keywordCollectionView.isHidden = !isKeywordExist
  }

  func createKeywordList(searchKeyword:String) {
    
    let splittedSearchKeyword = searchKeyword.components(separatedBy: " ")
    
    for keyword in splittedSearchKeyword {
      if keyword.characters.count > 0 {
        keywordList.append(keyword)
      }
    }

  }
  
  func displayKeywordStringInTextView(searchKeyword:String) {
    if !searchKeyword.isEmpty {
      let replacedString = searchKeyword.replacingOccurrences(of: " ", with: " , ")
      textView.text = replacedString
    } else {
      textView.text = searchKeyword
    }
  }
  
  func clearKeywordList() {
    keywordList = []
  }
  
  func setSearchKeyword(searchKeyword:String) {
    keywordString = searchKeyword
  }
}


extension ViewController : KeywordInputViewControllerDelegate {
  
  func passSearchKeyword(searchKeyword: String) {
    
    setSearchKeyword(searchKeyword:searchKeyword)
    clearKeywordList()
    displayKeywordStringInTextView(searchKeyword: searchKeyword)
    
    if searchKeyword != "" {
      createKeywordList(searchKeyword: searchKeyword)
      displaySearchContainerSubViews(isKeywordExist: true)
    } else {
      displaySearchContainerSubViews(isKeywordExist: false)
    }
    
    DispatchQueue.main.async {
      self.searchView.keywordCollectionView.reloadData()
    }
  }
  
}


extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return keywordList.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SearchKeywordCollectionViewCell
  
    cell.keywordLabel.textColor = UIColor.white
    cell.keywordLabel.text = keywordList[indexPath.item]
    
    return cell

  }
  
}

extension UINavigationController {
  override open var childViewControllerForStatusBarStyle: UIViewController? {
    return self.topViewController
  }
}


