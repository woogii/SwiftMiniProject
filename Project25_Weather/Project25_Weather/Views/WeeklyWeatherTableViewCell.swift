//
//  WeeklyWeatherTableViewCell.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK: - WeeklyWeatherTableViewCell: UITableViewCell
class WeeklyWeatherTableViewCell: UITableViewCell {
  // MARK: - Property List
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var temparatureLabel: UILabel!
}
