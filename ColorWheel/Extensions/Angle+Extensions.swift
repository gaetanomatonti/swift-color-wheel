//
//  Angle+Extensions.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import Foundation
import SwiftUI

extension Angle {
  /// Creates a new instance of the angle with an absolute (positive) value.
  var absolute: Angle {
    get {
      if radians < .zero {
        return Angle(radians: radians + .pi * 2)
      }

      return self
    }
    set {
      self = newValue.absolute
    }
  }
}
