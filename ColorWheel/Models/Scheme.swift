//
//  Scheme.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation
import SwiftUI

/// A type that represents a color scheme.
struct ColorScheme {

  /// The closure that computes the colors in the scheme.
  typealias ColorsProvider = (HSB) -> [HSB]

  // MARK: - Stored Properties

  /// The label that describes the color scheme.
  let label: String

  /// The base color of the scheme.
  let baseColor: HSB

  /// The closure that computes the colors in the scheme.
  private let colorsProvider: ColorsProvider

  // MARK: - Computed Properties

  /// The colors in `HSB` format.
  var hsbColors: [HSB] {
    let colors = [baseColor] + colorsProvider(baseColor)
    return colors.sorted { $0.hue < $1.hue }
  }

  /// The SwiftUI `Color` representation of the colors.
  var colors: [Color] {
    hsbColors.map(\.color)
  }

  // MARK: - Init

  init(_ label: String, baseColor: HSB, colorsProvider: @escaping ColorsProvider) {
    self.label = label
    self.baseColor = baseColor
    self.colorsProvider = colorsProvider
  }
}

extension ColorScheme {
  static func monochromatic(from color: HSB) -> ColorScheme {
    ColorScheme("Monochromatic", baseColor: color) { _ in [] }
  }

  static func analogous(from color: HSB, distance: Angle) -> ColorScheme {
    ColorScheme("Analogous", baseColor: color) { base in
      [
        HSB(id: 1, hue: base.hue - distance, saturation: base.saturation, brightness: base.brightness),
        HSB(id: 2, hue: base.hue + distance, saturation: base.saturation, brightness: base.brightness),
      ]
    }
  }

  static func complementary(from color: HSB) -> ColorScheme {
    ColorScheme("Complementary", baseColor: color) { base in
      [
        HSB(id: 1, hue: base.hue + .degrees(180), saturation: base.saturation, brightness: base.brightness),
      ]
    }
  }

  static func triad(from color: HSB) -> ColorScheme {
    ColorScheme("Triad", baseColor: color) { base in
      [
        HSB(id: 1, hue: base.hue + .degrees(120), saturation: base.saturation, brightness: base.brightness),
        HSB(id: 2, hue: base.hue + .degrees(240), saturation: base.saturation, brightness: base.brightness),
      ]
    }
  }

  static func square(from color: HSB) -> ColorScheme {
    ColorScheme("Square", baseColor: color) { base in
      [
        HSB(id: 1, hue: base.hue + .degrees(90), saturation: base.saturation, brightness: base.brightness),
        HSB(id: 2, hue: base.hue + .degrees(180), saturation: base.saturation, brightness: base.brightness),
        HSB(id: 3, hue: base.hue + .degrees(270), saturation: base.saturation, brightness: base.brightness),
      ]
    }
  }
}

/// An enumeration of the possible color harmony schemes.
enum Scheme: Int, CaseIterable {
  /// A monochromatic scheme.
  ///
  /// This scheme does not provide additional colors.
  case monochromatic

  /// The analogous scheme.
  ///
  /// This scheme provides colors that are slightly distant from the starting hue.
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

  /// Computes the colors in the harmony schemes from a base color.
  /// - Parameter base: The base color of the scheme.
  /// - Returns: The array of `HSB` colors in the harmony scheme.
  func colors(from base: HSB) -> [HSB] {
    switch self {
      case .monochromatic:
        return ColorScheme.monochromatic(from: base).hsbColors

      case .analogous:
        return ColorScheme.analogous(from: base, distance: .degrees(25)).hsbColors

      case .complementary:
        return ColorScheme.complementary(from: base).hsbColors

      case .triad:
        return ColorScheme.triad(from: base).hsbColors

      case .square:
        return ColorScheme.square(from: base).hsbColors
    }
  }
}
