//
//  Dictionary+Subscript.swift
//  Colour Memory
//
//  Created by siwook on 2017. 8. 30..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - Dictionary ( Subscripting support )

extension Dictionary {

  // MARK : Subscripting Dictionary By Index
  subscript(index: Int) -> (key: Key, value: Value) {
    get {
      return self[self.index(self.startIndex, offsetBy: index)]
    }
  }

}
