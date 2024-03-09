//
//  Color+Extensions.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import Foundation
import SwiftUI

extension Color {
  /// Creates a constant color from hue, saturation, and brightness values.
  /// - Parameters:
  ///   - hue: The angle value of the hue.
  ///   - saturation: The saturation of the color in the range `0` to `1`.
  ///   - brightness: The brightness of the color in the range `0` to `1`.
  init(hue: Angle, saturation: Double, brightness: Double, opacity: Double = 1.0) {
    self.init(
      hue: hue.absolute.degrees.truncatingRemainder(dividingBy: 360) / 360,
      saturation: saturation,
      brightness: brightness,
      opacity: opacity
    )
  }
}
