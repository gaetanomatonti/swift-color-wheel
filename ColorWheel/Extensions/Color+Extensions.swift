//
//  Color+Extensions.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import Foundation
import SwiftUI

extension Color {
  init(hue: Angle, saturation: Double, brightness: Double, opacity: Double = 1.0) {
    self.init(
      hue: hue.degrees.truncatingRemainder(dividingBy: 360) / 360,
      saturation: saturation,
      brightness: brightness,
      opacity: opacity
    )
  }
}
