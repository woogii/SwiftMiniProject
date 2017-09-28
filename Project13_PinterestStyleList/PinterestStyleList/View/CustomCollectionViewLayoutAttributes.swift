/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
//
//  CustomCollectionViewLayoutAttributes.swift
//  PinterestStyleList
//
//  Created by siwook on 2017. 5. 28..
//  Based on the code in the free tutorial from raywenderlich.com
import UIKit
// MARK : - CustomCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes
class CustomCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  // MARK : - Property
  var photoHeight: CGFloat = 0.0
  override func copy(with zone: NSZone? = nil) -> Any {
    guard let copy = super.copy(with: zone) as? CustomCollectionViewLayoutAttributes else {
      return CustomCollectionViewLayoutAttributes()
    }
    copy.photoHeight = photoHeight
    return copy
  }
  override func isEqual(_ object: Any?) -> Bool {
    if let attributes = object as? CustomCollectionViewLayoutAttributes {
      if attributes.photoHeight == photoHeight {
        return super.isEqual(object)
      }
    }
    return false
  }
}
