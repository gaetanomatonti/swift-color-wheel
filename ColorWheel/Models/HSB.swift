//
//  HSB.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import Foundation
import SwiftUI

/// A representation of a color expressed in HSB (Hue-Saturation-Brightness) values.
struct HSB: Hashable {

  // MARK: - Stored Properties

  /// The hue value.
  let hue: Angle

  /// The saturation value.
  let saturation: Double

  /// The brightness value.
  let brightness: Double

  // MARK: - Init

  init(hue: Angle, saturation: Double, brightness: Double) {
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
  }

  // MARK: - Computed Properties

  /// The `Color` represented in HSB values.
  var color: Color {
    Color(hue: hue.radians / (.pi * 2), saturation: saturation, brightness: 1)
  }

  /// Computes the coordinates of the color in the polar coordinates of the passed rectangle.
  /// - Parameter rect: The rectangle in which to position the color.
  /// - Returns: The coordinates of the color in the passed rectangle.
  func position(in rect: CGRect) -> CGPoint {
    .from(angle: hue, radius: saturation, in: rect)
  }
}

extension HSB: Identifiable {
  var id: Int {
    hashValue
  }
}
