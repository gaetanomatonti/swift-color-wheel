//
//  ColorSlider+Modifiers.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation
import SwiftUI

fileprivate enum ColorSliderGrabberStyle: EnvironmentKey {
  static var defaultValue: AnyShapeStyle = AnyShapeStyle(Color.blue)
}

extension EnvironmentValues {
  var colorSliderGrabberStyle: AnyShapeStyle {
    get {
      self[ColorSliderGrabberStyle.self]
    }
    set {
      self[ColorSliderGrabberStyle.self] = newValue
    }
  }
}

extension View {
  func colorSliderGrabberStyle(_ style: some ShapeStyle) -> some View {
    environment(\.colorSliderGrabberStyle, AnyShapeStyle(style))
  }
}
