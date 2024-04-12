//
//  ControlPoint.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation
import SwiftUI
import Vectors

/// A view that displays a draggable control point that controls color selection.
struct ControlPoint: View {

  // MARK: - Stored Properties

  /// The hue of the currently selected color.
  @Binding private var hue: Angle

  /// The saturation of the currently selected color.
  @Binding private var saturation: Double

  /// The brightness of the currently selected color.
  private var brightness: Double

  /// The current position of the control point.
  @State private var position: CGPoint

  /// The frame of the circle.
  private let frame: CGRect

  // MARK: - Computed Properties

  /// The center of the circle.
  var center: CGPoint {
    frame.center
  }

  /// The radius of the circle.
  var radius: CGFloat {
    frame.width / 2
  }

  /// The currently selected color.
  private var color: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness)
  }

  // MARK: - Body

  init(hue: Binding<Angle>, saturation: Binding<Double>, brightness: Double, frame: CGRect) {
    self._hue = hue
    self._saturation = saturation
    self.brightness = brightness
    self.frame = frame

    self.position = CGPoint(
      angle: hue.wrappedValue,
      radius: saturation.wrappedValue * frame.width / 2,
      center: frame.center
    )
  }

  // MARK: - Body

  var body: some View {
    ColorPoint(color: color)
      .frame(width: 48, height: 48)
      .position(position)
      .gesture(
        DragGesture()
          .onChanged { value in
            updateColor(from: value.location)
          }
      )
      .onChange(of: hue) { oldValue, newValue in
        updatePosition(from: newValue, saturation: saturation)
      }
      .onChange(of: saturation) { oldValue, newValue in
        updatePosition(from: hue, saturation: newValue)
      }
  }

  // MARK: Functions

  /// Updates the color from the coordinates of the control point.
  private func updateColor(from location: CGPoint) {
    let position = (location - center).limit(radius)
    updateHue(from: position)
    updateSaturation(from: position)
  }

  /// Updates the hue of the color from the angle of the control point.
  private func updateHue(from position: CGPoint) {
    hue = position.normalized.heading
  }

  /// Updates the saturation of the color from the distance of the control point to the center.
  private func updateSaturation(from position: CGPoint) {
    saturation = position.magnitude / radius
  }
  
  private func updatePosition(from hue: Angle, saturation: CGFloat) {
    position = CGPoint(
      angle: hue,
      radius: saturation * frame.width / 2,
      center: frame.center
    )
  }
}
