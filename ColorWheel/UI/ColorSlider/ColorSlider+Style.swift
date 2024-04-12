//
//  ColorSlider+Modifiers.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation
import SwiftUI

/// The `EnvironmentKey` to set the shape style of the ``ColorSider`` track.
fileprivate enum ColorSliderTrackStyle: EnvironmentKey {
  static var defaultValue: AnyShapeStyle = AnyShapeStyle(.background)
}

/// The `EnvironmentKey` to set the shape style of the ``ColorSider`` grabber.
fileprivate enum ColorSliderGrabberStyle: EnvironmentKey {
  static var defaultValue: AnyShapeStyle = AnyShapeStyle(Color.blue)
}

extension EnvironmentValues {
  /// The shape style of the ``ColorSlider`` track.
  var colorSliderTrackStyle: AnyShapeStyle {
    get {
      self[ColorSliderTrackStyle.self]
    }
    set {
      self[ColorSliderTrackStyle.self] = newValue
    }
  }

  /// The shape style of the ``ColorSlider`` grabber.
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
  /// Sets the `ShapeStyle` for the ``ColorSlider`` track.
  /// - Parameter style: The style of the track.
  func colorSliderTrackStyle(_ style: some ShapeStyle) -> some View {
    environment(\.colorSliderTrackStyle, AnyShapeStyle(style))
  }

  /// Sets the `ShapeStyle` for the ``ColorSlider`` grabber.
  /// - Parameter style: The style of the grabber.
  func colorSliderGrabberStyle(_ style: some ShapeStyle) -> some View {
    environment(\.colorSliderGrabberStyle, AnyShapeStyle(style))
  }
}
