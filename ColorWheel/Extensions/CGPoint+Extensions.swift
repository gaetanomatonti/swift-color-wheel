//
//  CGPoint+VectorOperations.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation
import SwiftUI

// MARK: - Operators

extension CGPoint {
  /// Adds a vector to this vector.
  /// - Returns: The vector resulting from the sum of the vectors.
  static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  /// Subtracts a vector to this vector.
  /// - Returns: The vector resulting from the subtraction of the vectors.
  static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
  }

  /// Multiplies (or scales) the vector by a scalar.
  /// - Returns: The scaled vector.
  static func *(lhs: CGPoint, n: CGFloat) -> CGPoint {
    CGPoint(x: lhs.x * n, y: lhs.y * n)
  }

  /// Divides (or scales) the vector by a scalar.
  /// - Returns: The scaled vector.
  static func /(lhs: CGPoint, n: CGFloat) -> CGPoint {
    CGPoint(x: lhs.x / n, y: lhs.y / n)
  }
}

// MARK: - Helpers

extension CGPoint {
  /// Returns a vector normalized to a unit length of 1.
  var normalized: CGPoint {
    let magnitude = self.magnitude

    guard magnitude > .zero else {
      return self
    }

    return self / magnitude
  }

  /// Returns the magnitude (or length) of the vector.
  var magnitude: CGFloat {
    sqrt(x * x + y * y)
  }

  /// Limits the magnitude of the vector.
  /// - Parameter maximum: The maximum magnitude of the vector.
  /// - Returns: A limited vector.
  func limit(_ maximum: CGFloat) -> CGPoint {
    guard magnitude > maximum else {
      return self
    }

    return normalized * maximum
  }
}

// MARK: - HSB

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
