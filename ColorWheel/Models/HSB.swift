//
//  HSB.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import Foundation
import SwiftUI

/// A representation of a color expressed in HSB (Hue-Saturation-Brightness) values.
struct HSB: Hashable, Identifiable {

  // MARK: - Stored Properties

  let id: Int

  /// The hue value.
  let hue: Angle

  /// The saturation value.
  let saturation: Double

  /// The brightness value.
  let brightness: Double

  /// The opacity value.
  let opacity: Double

  // MARK: - Init

  init(id: Int = 0, hue: Angle, saturation: Double, brightness: Double, opacity: Double = 1.0) {
    self.id = id
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
    self.opacity = opacity
  }

  // MARK: - Computed Properties

  /// The `Color` represented in HSB values.
  var color: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness, opacity: opacity)
  }
}
