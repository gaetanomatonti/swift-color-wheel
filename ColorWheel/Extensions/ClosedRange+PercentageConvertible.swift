//
//  ClosedRange+PercentageConvertible.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation

extension ClosedRange where Bound: PercentageConvertible {
  /// Computes the value represented by the passed percentage.
  /// - Parameter percentage: The percentage of the value.
  /// - Returns: The value corresponding to the percentage in the range.
  func value(from percentage: Double) -> Bound {
    Bound.value(from: percentage, in: self)
  }
}
