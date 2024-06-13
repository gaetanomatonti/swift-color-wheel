//
//  HSB.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import Foundation
import SwiftUI

/// A representation of a color expressed in HSB (Hue-Saturation-Brightness) values.
class HSB: Identifiable {

  // MARK: - Stored Properties

  let id: Int

  /// The hue value.
  var hue: Angle

  /// The saturation value.
  var saturation: Double

  /// The brightness value.
  var brightness: Double

  // MARK: - Init

  init(id: Int = 0, hue: Angle, saturation: Double, brightness: Double) {
    self.id = id
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
  }

  // MARK: - Computed Properties

  /// The `Color` represented in HSB values.
  var color: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness)
  }
}

extension HSB: Equatable {
  static func ==(lhs: HSB, rhs: HSB) -> Bool {
    lhs.id == rhs.id && lhs.hue == rhs.hue && lhs.saturation == rhs.saturation && lhs.brightness == rhs.brightness
  }
}

extension HSB: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension HSB {
  static var white: HSB {
    HSB(hue: .degrees(0), saturation: 0, brightness: 1)
  }
}
