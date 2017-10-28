//
//  ViewController.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import CoreData
import Toaster

// MARK : - RestaurantListViewController: UIViewController
class RestaurantListViewController: UIViewController {

  // MARK : - Property
  @IBOutlet weak var searchFieldContainerTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var pickerContainerView: UIView!
  @IBOutlet weak var sortOptionsPickerView: UIPickerView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchFieldContainerView: UIView!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var sortingButton: UIButton!
  private var overlayView = UIView()
  private lazy var opaqueView: UIView = {
    let opaqueView = UIView()
    opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return opaqueView
  }()
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(RestaurantListViewController.handleRefresh(_:)),
                                              for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  fileprivate var restaurantList = [Restaurant]()
  fileprivate var filteredRestaurantList = [Restaurant]()
  fileprivate var enteredSearchKeyword: String = ""
  var managedContext: NSManagedObjectContext!
  var favoriteRestaurantList = [FavoriteRestaurant]()
  // 'best match' is default sorting option
  var selectedSortOption = Constants.SortOption.BestMatch
  fileprivate var headerView: CustomHeaderView!
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchRestaurantList()
    updateFavoritePropertyInRestaurantList()
    sortRestaurantList(sortOption: selectedSortOption)
    configureSortOptionsPickerView()
    addRefreshControl()
    configureTableViewHeader()
    configureSearchTextField()
    addOverlayViewForHeaderImage()
  }

  private func configureTableViewHeader() {
    guard let header = tableView.tableHeaderView as? CustomHeaderView else { return }
    headerView = header
    headerView.backgroundImage = UIImage(named: Constants.Images.HeaderImage)

    tableView.tableHeaderView = nil
    tableView.addSubview(headerView)
    tableView.contentInset = UIEdgeInsets(top: Constants.TableViewHeaderHeight, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -Constants.TableViewHeaderHeight)
  }
  private func addOverlayViewForHeaderImage() {
    overlayView.backgroundColor = Constants.Colors.LightBlack
    headerView.addSubview(overlayView)
    overlayView.translatesAutoresizingMaskIntoConstraints = false
    overlayView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
    overlayView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
    overlayView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    overlayView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
  }
  fileprivate func updateHeaderView() {
    var headerRect = CGRect(x: 0, y: -Constants.TableViewHeaderHeight,
                            width: tableView.bounds.width, height: Constants.TableViewHeaderHeight)
    if tableView.contentOffset.y < -Constants.TableViewHeaderHeight {
      headerRect.origin.y = tableView.contentOffset.y
      headerRect.size.height = -tableView.contentOffset.y
    } else if tableView.contentOffset.y > -(Constants.TableViewHeaderHeight/2.0) {
      headerRect.origin.y = tableView.contentOffset.y - (Constants.TableViewHeaderHeight/2.0)
    }
    headerView.frame = headerRect
  }

  private func addRefreshControl() {
    if #available(iOS 10.0, *) {
      tableView.refreshControl = refreshControl
    } else {
      tableView.addSubview(refreshControl)
    }
  }

  func handleRefresh(_ refreshControl: UIRefreshControl) {
    sortRestaurantList(sortOption: selectedSortOption)
    self.tableView.reloadData()
    refreshControl.endRefreshing()
  }
  private func sortRestaurantList(sortOption: String) {
    restaurantList = Restaurant.sortListByOptions(restaurantList: restaurantList,
                                                  selectedSortOption: sortOption)
    self.tableView.reloadData()
  }
  // MARK : - Fetch the list of restaurant
  private func fetchRestaurantList() {
    let bundle = Bundle(for: type(of: self))
    guard let fetchedList = Restaurant.fetchRestaurantList(fileName: Constants.SampleResource.FileName,
                                                           bundle: bundle) else {
      return
    }
    restaurantList = fetchedList
  }

  // MARK : - Update Favorite Property
  private func updateFavoritePropertyInRestaurantList() {
    if favoriteRestaurantList.count > 0 {
      _ = restaurantList.map { (restaurant) -> Bool in
                                return favoriteRestaurantList.contains(where: { $0.name == restaurant.name })}
                          .enumerated().filter({$1 == true})
                            .map({ restaurantList[$0.0].isFavorite = true })
    }
  }
  private func configureSortOptionsPickerView() {
    let toolBar = createToolbarInPickerView()
    pickerContainerView.addSubview(toolBar)
    displayPickerContainerBasedOn(isHidden: true)
  }
  private func createToolbarInPickerView() -> UIToolbar {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor.black
    toolBar.sizeToFit()
    let cancelButton = UIBarButtonItem(title: Constants.Title.Cancel, style: UIBarButtonItemStyle.plain,
                                       target: self, action: #selector(cancelSortOption(_:)))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                      target: nil, action: nil)
    let selectButton = UIBarButtonItem(title: Constants.Title.Select, style: UIBarButtonItemStyle.plain,
                                       target: self, action: #selector(selectSortOption(_:)))
    toolBar.setItems([cancelButton, spaceButton, selectButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    return toolBar
  }

  // MARK : - Actions
  @IBAction func tappedSearchCancelButton(_ sender: Any) {
    reconfigureSearchRelatedUI()
    animateSearchViewWith(constraint: Constants.SearchContainerTopConstraintForHidden)
  }
  @IBAction func searchButtonTapped(_ sender: UIButton) {
    animateSearchViewWith(constraint: Constants.SearchContainerTopConstraintForShow)
    self.searchTextField.becomeFirstResponder()
  }
  private func animateSearchViewWith(constraint: CGFloat) {
    UIView.animate(withDuration: 0.4, animations: {
      self.searchFieldContainerTopConstraint.constant = constraint
      self.view.layoutIfNeeded()
    })
  }
  @IBAction func tappedSortingButton(_ sender: Any) {
    displayPickerContainerBasedOn(isHidden: false)
    displayOpaqueviewBasedOn(isHidden: false)
  }
  func cancelSortOption(_ sender:Any) {
    displayPickerContainerBasedOn(isHidden: true)
    displayOpaqueviewBasedOn(isHidden: true)
  }
  func selectSortOption(_ sender:Any) {
    displayPickerContainerBasedOn(isHidden: true)
    displayOpaqueviewBasedOn(isHidden: true)
    // Get A Selected Index From UIPickerView
    let selectedIndex = sortOptionsPickerView.selectedRow(inComponent: 0)
    selectedSortOption = Constants.SortOptionsArray[selectedIndex]
    sortRestaurantList(sortOption: selectedSortOption)
  }

  private func displayPickerContainerBasedOn(isHidden: Bool) {
    pickerContainerView.isHidden = isHidden
  }

  private func displayOpaqueviewBasedOn(isHidden: Bool) {
    if isHidden == false {
      if let window = UIApplication.shared.keyWindow {
        // Place an opaqueView right above the UIPickerView
        window.addSubview(opaqueView)
        let opaqueViewFrame = CGRect(x: 0, y: 0, width: window.frame.size.width,
                                   height: window.frame.size.height - Constants.PickerContainerHeight)
        self.opaqueView.frame = opaqueViewFrame
        self.opaqueView.alpha = 1.0
      }
    } else {
      self.opaqueView.alpha = 0.0
      opaqueView.removeFromSuperview()
    }
  }

  // MARK : - Reconfigure SearchUI
  private func reconfigureSearchRelatedUI() {
    searchTextField.resignFirstResponder()
    searchTextField.text = ""
    enteredSearchKeyword = ""
    tableView.reloadData()
  }

  // MARK : - Configure SearchTextField
  private func configureSearchTextField() {
    searchTextField.setLeftPaddingPoints(Constants.TextFieldLeftPadding)
    searchTextField.layer.cornerRadius = 5
  }
  // MARK : - Check Filtering Operation
  fileprivate func isFiltering() -> Bool {
    return !searchFieldContainerView.isHidden && !searchKeywordIsEmpty()
  }

  fileprivate func searchKeywordIsEmpty() -> Bool {
    // Returns true if the text is empty
    return enteredSearchKeyword.isEmpty
  }
}

// MARK : - RestaurantListViewController: UITableViewDelegate, UITableViewDataSource
extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {

  // MARK : - UITableViewDataSource Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filteredRestaurantList.count
    }
    return restaurantList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIDs.RestaurantInfoTableViewCell,
                                                   for: indexPath) as? RestaurantInfoTableViewCell else {
      return RestaurantInfoTableViewCell()
    }
    configureCell(cell, at:indexPath)
    return cell
  }
  private func configureCell(_ cell: RestaurantInfoTableViewCell, at indexPath: IndexPath) {
    filterList(cell, at: indexPath)
  }

  // MARK : - Configure Cell Based on Filtered Data Source
  private func filterList(_ cell: RestaurantInfoTableViewCell, at indexPath: IndexPath) {
    if !isFiltering() {
      let restaurant = restaurantList[indexPath.row]
      cell.restaurantInfo = restaurant
      setFavoriteButtonAction(cell, at: indexPath)
    } else {
      let filteredRestaurant = filteredRestaurantList[indexPath.row]
      cell.restaurantInfo = filteredRestaurant
      setFilteredListFavoriteButtonAction(cell, at: indexPath, filteredRestaurant: filteredRestaurant)
    }
  }
  private func displayToastMessageBasedOn(isFavorite: Bool) {
    let message: String
    if isFavorite {
      message = Constants.ToastMsg.FavoriteMarked
    } else {
      message = Constants.ToastMsg.FavoriteUnMarked
    }
    let toast = Toast(text: message, delay: 0.0, duration: Constants.ToastMsg.Duration)
    toast.show()
  }
  // MARK : - Set Favorite Button Action in the List
  private func setFavoriteButtonAction(_ cell: RestaurantInfoTableViewCell,
                                       at indexPath: IndexPath) {
    cell.favoriteButtonTapAction = { [unowned self] in
      // Toggle isFavorite Property
      self.restaurantList[indexPath.row].isFavorite = !self.restaurantList[indexPath.row].isFavorite
      // Trigger Cell UI Update
      cell.restaurantInfo = self.restaurantList[indexPath.row]
      // Display Toast Message 
      self.displayToastMessageBasedOn(isFavorite: self.restaurantList[indexPath.row].isFavorite)
      // Update Database
      let updatedRestaurant = self.restaurantList[indexPath.row]
      self.updateFavoriteRestaurantDatabase(updatedRestaurant)
    }
  }
  // MARK : - Set Favorite Button Action in the Filtered List
  private func setFilteredListFavoriteButtonAction(_ cell: RestaurantInfoTableViewCell,
                                                   at indexPath: IndexPath, filteredRestaurant: Restaurant) {
    cell.favoriteButtonTapAction = { [unowned self] in
      // Find an index to update the isFavorite property.
      // Suppose that the name of the restaurant is unique
      if let index = self.restaurantList.index(where: { return $0.name == filteredRestaurant.name }) {
        // Toggle Non-Filtered Restaurant isFavorite Property
        self.restaurantList[index].isFavorite = !self.filteredRestaurantList[indexPath.row].isFavorite
        // Toggle Filtered Restaurant isFavorite Property
        self.filteredRestaurantList[indexPath.row].isFavorite = !self.filteredRestaurantList[indexPath.row].isFavorite
        // Trigger Cell UI Update
        cell.restaurantInfo = self.filteredRestaurantList[indexPath.row]
        // Display Toast Message
        self.displayToastMessageBasedOn(isFavorite: self.restaurantList[indexPath.row].isFavorite)
        // Update Database
        let updatedRestaurant = self.restaurantList[index]
        self.updateFavoriteRestaurantDatabase(updatedRestaurant)
      }
    }
  }
  private func updateFavoriteRestaurantDatabase(_ restaurant: Restaurant) {
    FavoriteRestaurant.findRestaurantAndUpdate(matching: restaurant, in: managedContext)
  }
}

// MARK : - RestaurantListViewController: UITextFieldDelegate
extension RestaurantListViewController : UITextFieldDelegate {
  // MARK : - UITextFieldDelegate Methods
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    if string.isEmpty {
      enteredSearchKeyword = String(enteredSearchKeyword.characters.dropLast())
    } else {
      enteredSearchKeyword = (textField.text ?? "") + string
    }
    filterRestaurantListForSearchText(enteredSearchKeyword)
    return true
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == searchTextField {
      searchTextField.resignFirstResponder()
      return false
    }
    return true
  }
  // MARK : - Filter List with Keyword
  func filterRestaurantListForSearchText(_ searchKeyword: String) {
    filteredRestaurantList = restaurantList.filter { restaurant -> Bool in
      return restaurant.name.lowercased().contains(searchKeyword.lowercased())
    }
    tableView.reloadData()
  }
}

// MARK: - RestaurantListViewController: UIPickerViewDataSource
extension RestaurantListViewController: UIPickerViewDataSource, UIPickerViewDelegate {

  // MARK: - UIPickerView DataSource Method
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Constants.PickerViewRowText.count
  }
  // MARK: - UIPickerView Delegate Method
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return Constants.PickerViewRowText[row]
  }
}
// MARK: - RestaurantListViewController: UIScrollViewDelegate
extension RestaurantListViewController: UIScrollViewDelegate {
  // MARK: - UIScrollViewDelegate Method
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //print("content offset : \(scrollView.contentOffset)")
    updateHeaderView()
  }
}
