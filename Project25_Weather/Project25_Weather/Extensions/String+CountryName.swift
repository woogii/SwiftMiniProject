//
//  String+CountryName.swift
//  StrvWeather
//
//  Created by siwook on 2017. 11. 28..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - String Extension For Country
extension String {
  func getCountryFromCountryCode() -> String {
    let current = Locale(identifier: Constants.UsLocale)
    // Get country based on country code
    return current.localizedString(forRegionCode: self) ?? ""
  }
}
