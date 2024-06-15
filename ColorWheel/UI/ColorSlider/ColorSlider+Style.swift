//
//  ColorSlider+Modifiers.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/04/24.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
  /// The shape style of the ``ColorSlider`` track.
  @Entry var colorSliderTrackStyle = AnyShapeStyle(.background)

  /// The shape style of the ``ColorSlider`` grabber.
  @Entry var colorSliderGrabberStyle = AnyShapeStyle(.blue)
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
