//
//  DescriptionItem.swift
//  LBACareerAppDemo
//
//  Created by siwook on 2017. 7. 22..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - DescriptionItem

struct DescriptionItem {

  // MARK : - Property

  var title: String
  var description: String

  // MARK : - Initialization

  init(title: String, description: String) {
    self.title = title
    self.description = description
  }

  // MARK : - Get List of DescriptionItem 

  static func getListOfDescriptionItems() -> [DescriptionItem] {

    return [DescriptionItem(title:Constant.DummyData.FirstTitle,
                            description: Constant.DummyData.FirstDescription),

            DescriptionItem(title:Constant.DummyData.SecondTitle, description:Constant.DummyData.Seconddescription),
            DescriptionItem(title:Constant.DummyData.ThirdTitle, description: Constant.DummyData.ThirdDescription),
            DescriptionItem(title:Constant.DummyData.FourthTitle, description:Constant.DummyData.FourthDescription)]
  }
}
