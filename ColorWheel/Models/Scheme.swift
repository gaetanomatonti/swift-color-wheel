//
//  Scheme.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation
import SwiftUI

/// An enumeration of the possible color harmony schemes.
enum Scheme: Int, CaseIterable {
  /// A monochromatic scheme.
  ///
  /// This scheme does not provide additional colors.
  case monochromatic

  /// The analogous scheme.
  ///
  /// This scheme provides colors that are 30° apart from the starting hue.
  case analogous

  /// The complementary scheme.
  ///
  /// This scheme provides a color that is opposite in hue to the starting one.
  case complementary

  /// The triad complementary scheme.
  ///
  /// This scheme provides a color that are 120° degrees apart from the starting hue.
  case triad

  /// The triad complementary scheme.
  ///
  /// This scheme provides a color that are 90° degrees apart from the starting hue.
  case square
}

// MARK: - Computed Properties

extension Scheme {
  /// The title of the scheme.
  var title: String {
    switch self {
      case .monochromatic:
        "Monochromatic"

      case .analogous:
        "Analogous"

      case .complementary:
        "Complementary"

      case .triad:
        "Triad"

      case .square:
        "Square"
    }
  }
}

// MARK: - Functions

extension Scheme {
  /// Computes the additional colors in the harmony schemes starting from the passed hue and saturation.
  /// - Parameters:
  ///   - hue: The hue of the starting color.
  ///   - saturation: The saturation of the starting color.
  /// - Returns: The array of `HSB` colors in the harmony scheme.
  func colors(from hue: Angle, saturation: CGFloat) -> [HSB] {
    switch self {
      case .monochromatic:
        return []

      case .analogous:
        return [
          HSB(id: 1, hue: hue - .degrees(30), saturation: saturation, brightness: 1),
          HSB(id: 2, hue: hue + .degrees(30), saturation: saturation, brightness: 1),
        ]

      case .complementary:
        return [
          HSB(id: 1, hue: hue + .degrees(180), saturation: saturation, brightness: 1),
        ]

      case .triad:
        return [
          HSB(id: 1, hue: hue - .degrees(120), saturation: saturation, brightness: 1),
          HSB(id: 2, hue: hue + .degrees(120), saturation: saturation, brightness: 1),
        ]

      case .square:
        return [
          HSB(id: 1, hue: hue + .degrees(90), saturation: saturation, brightness: 1),
          HSB(id: 2, hue: hue + .degrees(180), saturation: saturation, brightness: 1),
          HSB(id: 3, hue: hue + .degrees(270), saturation: saturation, brightness: 1),
        ]
    }
  }
}
