//
//  PercentageConvertible.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation

/// A protocol defining requirements for a type that can be converted to a percentage value and vice versa.
protocol PercentageConvertible: Comparable {
  /// Computes the percentage of the value in the passed range.
  /// - Parameter range: The range of possible values.
  /// - Returns: A clamped `Double` value representing the percentage in the range `[0, 1]`.
  func percentage(in range: ClosedRange<Self>) -> Double

  /// Computes the value from the percentage in the passed range.
  /// - Parameters:
  ///   - percentage: The percentage of the value.
  ///   - range: The range of possible values.
  /// - Returns: A value corresponding to the percentage in the specified range.
  static func value(from percentage: Double, in range: ClosedRange<Self>) -> Self
}
