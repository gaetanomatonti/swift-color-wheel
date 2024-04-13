//
//  PercentageConvertible+BinaryFloatingPoint.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation

extension PercentageConvertible where Self: BinaryFloatingPoint {
  func percentage(in range: ClosedRange<Self>) -> Double {
    let value = self - range.lowerBound
    let total = range.upperBound - range.lowerBound
    return Double(value / total)
  }

  static func value(from percentage: Double, in range: ClosedRange<Self>) -> Self {
    let value = Self(percentage) * range.upperBound
    return max(range.lowerBound, min(value, range.upperBound))
  }
}

extension Float: PercentageConvertible {}

extension Double: PercentageConvertible {}

extension CGFloat: PercentageConvertible {}
