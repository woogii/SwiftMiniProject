//
//  RestaurantInfoTableViewCell.swift
//  RestaurantList
//
//  Created by siwook on 2017. 9. 18..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import Cosmos

// MARK : - RestaurantInfoTableViewCell: UITableViewCell
class RestaurantInfoTableViewCell: UITableViewCell {
  // MARK : - Property
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var deliveryCostSeparatorView: UIView!
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var openStatusLabel: UILabel!
  @IBOutlet weak var deliveryCostLabel: UILabel!
  @IBOutlet weak var minimumCostLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var openStatusSeparatorView: UIView!
  @IBOutlet var ratingAverageView: CosmosView!
  private let euroCurrencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: Constants.GermanLocale)
    return formatter
  }()
  var restaurantInfo: Restaurant! {
    didSet {
      updateUI()
    }
  }
  var favoriteButtonTapAction: (() -> Void)?

  // MARK : - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setCellBackgroundWhenTapped()
  }
  private func setCellBackgroundWhenTapped() {
    let selectionColorView = UIView()
    selectionColorView.backgroundColor = Constants.Colors.LightBlue
    selectedBackgroundView = selectionColorView
  }
  // MARK : - Action
  @IBAction func tappedFavoriteButton(_ sender: Any) {
    if favoriteButtonTapAction != nil {
      favoriteButtonTapAction!()
    }
  }
  // MARK : - Update Cell UI
  private func updateUI() {
    setRestaurantNameLabel()
    setRestaurantImageView()
    setOpenStatusRelatedViews()
    setRatingAverageView()
    setDeliveryCostLabel()
    setDistanceLabel()
    setMinimumCostLabel()
    setAverageRatingView()
    setFavoriteButtonImage()
  }
  private func setRestaurantNameLabel() {
    nameLabel.text = restaurantInfo.name
  }
  private func setDistanceLabel() {
    let distance = restaurantInfo.distance
    let convertedDistance = String(format:Constants.RestaurantInfo.DistanceFormat, (Float)(distance)/1000) +
      Constants.RestaurantInfo.KiloMeter
    distanceLabel.text = convertedDistance
  }
  private func setRatingAverageView() {
    ratingAverageView.rating = restaurantInfo.ratingAverage
  }
  private func setRestaurantImageView() {
    restaurantImageView.image = UIImage(named:restaurantInfo.imageName)
  }
  private func setAverageRatingView() {
    ratingAverageView.rating = Double(restaurantInfo.ratingAverage)
  }
  private func setDeliveryCostLabel() {
    if restaurantInfo.deliveryCosts == 0 {
      deliveryCostLabel.text = Constants.RestaurantInfo.Free
    } else {
      deliveryCostLabel.text = euroCurrencyFormatter.string(from: NSNumber(value: restaurantInfo.deliveryCosts))
    }
  }
  private func setMinimumCostLabel() {
    minimumCostLabel.text = euroCurrencyFormatter.string(from: NSNumber(value: restaurantInfo.minCost))
  }
  private func setOpenStatusRelatedViews() {
    func displayOpenStatusViewsBasedOn(isHiddenValue: Bool) {
      openStatusLabel.isHidden = isHiddenValue
      openStatusSeparatorView.isHidden = isHiddenValue
    }
    openStatusLabel.text = restaurantInfo.status
    if restaurantInfo.status == Constants.RestaurantInfo.Closed {
      openStatusLabel.textColor = UIColor.red
    } else if restaurantInfo.status == Constants.RestaurantInfo.OrderAhead {
      openStatusLabel.textColor = UIColor.orange
    } else {
      openStatusLabel.textColor = UIColor.green
    }
  }
  private func setFavoriteButtonImage() {
    if restaurantInfo.isFavorite == true {
      let image = UIImage(named: Constants.Images.HeartFilled)
      favoriteButton.setImage(image, for: UIControlState.normal)
    } else {
      let image = UIImage(named: Constants.Images.HeartOutline)
      favoriteButton.setImage(image, for: UIControlState.normal)
    }
  }
  // MARK : - Save and Restore colors of cell subviews
  override func setSelected(_ selected: Bool, animated: Bool) {
    let color = openStatusSeparatorView.backgroundColor
    super.setSelected(isHighlighted, animated: animated)
    setSeparatorViewsColors(color)
  }
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    let color = openStatusSeparatorView.backgroundColor
    super.setHighlighted(highlighted, animated: animated)
    setSeparatorViewsColors(color)
  }
  private func setSeparatorViewsColors(_ color: UIColor?) {
    openStatusSeparatorView.backgroundColor = color
    deliveryCostSeparatorView.backgroundColor = color
  }
}
