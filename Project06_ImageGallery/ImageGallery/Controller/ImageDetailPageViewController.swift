//
//  ImageDetailPageViewController.swift
//  ImageGallery
//
//  Created by siwook on 2017. 4. 8..
//  Copyright © 2017년 siwook. All rights reserved.
//
import Foundation
import UIKit
import SDWebImage

// MARK : - ImageDetailPageViewController: UIPageViewController,
//                                          UIPageViewControllerDataSource
class ImageDetailPageViewController: UIPageViewController,
                          UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  // MARK : - Property
  var imageUrlArray = [String]()
  var pageVCTitle = "DetailImage"
  var pageControl = UIPageControl()
  let pageControlWidth = 110
  let pageControlHeight = 20
  var currentPageIndex = 0
  var selectedIndex = 0
  var lastPendingViewControllerIndex: Int = 0
  var detailImageViewControllers = [DetailImageViewController]()
  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setDelegateAndDatasource()
    setVCBackgroundColor()
    setTitle()
    initDatasource()
    slideToPage(index: selectedIndex, viewControllersArray: detailImageViewControllers)
    addBarButtonItem()
    addPageControl()
    self.automaticallyAdjustsScrollViewInsets = false
  }
  func setDelegateAndDatasource() {
    dataSource = self
    delegate = self
  }
  func setTitle() {
    title = pageVCTitle
  }
  func setVCBackgroundColor() {
    view.backgroundColor = UIColor.white
  }
  func initDatasource() {
    imageUrlArray.reserveCapacity(imageUrlArray.count)
    for i in 0..<imageUrlArray.count {
      let frameViewController = DetailImageViewController()
      frameViewController.imageUrl = imageUrlArray[i]
      frameViewController.pageIndex = i
      detailImageViewControllers.append(frameViewController)
    }
  }
  private func slideToPage(index: Int,
                           viewControllersArray: [DetailImageViewController]) {
    let tempIndex = currentPageIndex
    if currentPageIndex <= index {
      for i in tempIndex...index {
        self.setViewControllers([viewControllersArray[i]],
                                direction: .forward,
                                animated: true,
                                completion: {[weak self] (complete: Bool) -> Void in
          if complete {
            self?.updateCurrentPageIndex(index: i)
          }
        })
      }
    }
  }
  func updateCurrentPageIndex(index: Int) {
    currentPageIndex = index
  }
  func addPageControl() {
    pageControl.numberOfPages = imageUrlArray.count
    pageControl.currentPage = selectedIndex
    pageControl.pageIndicatorTintColor = UIColor.gray
    pageControl.currentPageIndicatorTintColor = UIColor.white
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pageControl)
    view.bringSubview(toFront: pageControl)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    configurePageControlLayout()
  }
  func configurePageControlLayout() {
    pageControl.frame.size = CGSize(width: pageControlWidth, height: pageControlHeight)
    view.addConstraintsWithFormat(format: "V:[v0(20)]-30-|", views: pageControl)
    view.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .centerX,
                                          relatedBy: .equal, toItem: self.view, attribute: .centerX,
                                          multiplier: 1, constant: 0))
  }
  func addBarButtonItem() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:""),
                                      style: .plain, target: self,
                                      action: #selector(ImageDetailPageViewController.pushBackButton))
    navigationItem.leftBarButtonItem?.tintColor = UIColor.black
  }
  // MARK : - Action
  func pushBackButton() {
    _ = navigationController?.popViewController(animated: false)
  }
  // MARK : - UIPageViewControllerDataSourc
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let vc = viewController as? DetailImageViewController,
          let currentImageUrl = vc.imageUrl else {
      return nil
    }
    if let currentIndex = imageUrlArray.index(of:currentImageUrl) {
      if currentIndex > 0 {
        let frameViewController = DetailImageViewController()
        frameViewController.imageUrl = imageUrlArray[currentIndex - 1]
        frameViewController.pageIndex = currentIndex - 1
        return frameViewController
      }
    }
    return nil
  }
  func pageViewController(_ pageViewController: UIPageViewController,
                          willTransitionTo pendingViewControllers: [UIViewController]) {
    if let viewController = pendingViewControllers[0] as? DetailImageViewController {
      self.lastPendingViewControllerIndex = viewController.pageIndex
    }
  }
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let vc = viewController as? DetailImageViewController,
      let currentImageUrl = vc.imageUrl else {
      return nil
    }
    if let currentIndex = imageUrlArray.index(of:currentImageUrl) {
      if currentIndex < imageUrlArray.count - 1 {
        let frameViewController = DetailImageViewController()
        frameViewController.imageUrl = imageUrlArray[currentIndex + 1]
        frameViewController.pageIndex = currentIndex + 1
        return frameViewController
      }
    }
    return nil
  }
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    if completed {
      pageControl.currentPage = lastPendingViewControllerIndex
    }
  }
}

// MARK : - FrameViewController : UIViewController

class DetailImageViewController: UIViewController {
  // MARK : - Property
  var imageUrl: String? {
    didSet {
      imageView.sd_setImage(with: URL(string:imageUrl!),
                            placeholderImage: UIImage(named: imageUrl!),
                            options: SDWebImageOptions(), completed: { (image, _, _, _) in
        if image != nil {
          self.imageView.image = image
        }
      })
    }
  }
  var constraintApplied: Bool = false
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  var pageIndex: Int = 0
  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black
    view.addSubview(imageView)
    addViewConstraints()
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if !constraintApplied {
      addViewConstraints()
      constraintApplied = !constraintApplied
    }
  }
  func addViewConstraints() {
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|",
                                                       options: NSLayoutFormatOptions(),
                                                       metrics: nil,
                                                       views: ["v0": imageView]))
    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:|-80@750-[v0]-80@1000-|",
                                     options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
  }
  // MARK : - Target Action
  func pushBackButton() {
    _ = navigationController?.popViewController(animated: false)
  }
}
