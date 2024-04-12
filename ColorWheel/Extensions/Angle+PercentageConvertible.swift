//
//  PercentageConvertible+Angle.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation
import SwiftUI

extension Angle: PercentageConvertible {
  func percentage(in range: ClosedRange<Angle>) -> Double {
    let value = self.degrees - range.lowerBound.degrees
    let total = range.upperBound.degrees - range.lowerBound.degrees
    return Double(value / total)
  }

  static func value(from percentage: Double, in range: ClosedRange<Angle>) -> Angle {
    let value = percentage * range.upperBound.degrees
    let clampedValue = max(range.lowerBound.degrees, min(value, range.upperBound.degrees))
    return .degrees(clampedValue)
  }
}
