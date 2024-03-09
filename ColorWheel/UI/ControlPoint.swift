//
//  ControlPoint.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation
import SwiftUI

/// A view that displays a draggable control point that controls color selection.
struct ControlPoint: View {

  // MARK: - Stored Properties

  /// The hue of the currently selected color.
  @Binding private var hue: Angle

  /// The saturation of the currently selected color.
  @Binding private var saturation: Double

  /// The current position of the control point.
  @State private var position: CGPoint

  /// The frame of the circle.
  private let frame: CGRect

  // MARK: - Computed Properties

  /// The center of the circle.
  var center: CGPoint {
    frame.center
  }

  /// The radius of the center.
  var radius: CGFloat {
    frame.width / 2
  }

  /// The vector of the control point that points to the center of the circle.
  private var toCenter: CGPoint {
    center - position
  }

  /// The currently selected color.
  private var color: Color {
    Color(hue: hue, saturation: saturation, brightness: 1)
  }

  // MARK: - Body

  init(hue: Binding<Angle>, saturation: Binding<Double>, frame: CGRect) {
    self._hue = hue
    self._saturation = saturation
    self.frame = frame

    self.position = .from(
      angle: hue.wrappedValue,
      radius: saturation.wrappedValue,
      in: frame
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
            position = (value.location - center).limit(radius) + center

            updateColor()
          }
      )
  }

  // MARK: Functions

  /// Updates the color from the coordinates of the control point.
  private func updateColor() {
    updateHue()
    updateSaturation()
  }

  /// Updates the hue of the color from the angle of the control point.
  private func updateHue() {
    let normalizedToCenter = toCenter.normalized
    let angle = atan2(normalizedToCenter.y, normalizedToCenter.x) + .pi
    hue = .radians(angle)
  }

  /// Updates the saturation of the color from the distance of the control point to the center.
  private func updateSaturation() {
    saturation = toCenter.magnitude / radius
  }
}
