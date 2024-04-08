//
//  CGPoint+VectorOperations.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation
import SwiftUI
import Vectors

// MARK: - Helpers

extension CGPoint {
  /// Computes the cartesian-coordinates from polar-coordinates.
  /// - Parameters:
  ///   - angle: The angle of the coordinates.
  ///   - radius: The radius of the circle.
  ///   - rect: The rectangle containing the circle.
  /// - Returns: The computed cartesian-coordinates.
  static func from(angle: Angle, radius: Double, in rect: CGRect) -> CGPoint {
    let normalizedRadius = rect.width / 2 * radius

    return CGPoint(
      x: cos(angle.radians) * normalizedRadius,
      y: sin(angle.radians) * normalizedRadius
    ) + rect.center
  }
}
