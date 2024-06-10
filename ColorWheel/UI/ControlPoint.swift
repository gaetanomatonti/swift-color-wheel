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
  private let brightness: Double

  // MARK: - Computed Properties

  /// The currently selected color.
  private var color: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness)
  }

  // MARK: - Body

  init(hue: Binding<Angle>, saturation: Binding<Double>, brightness: Double) {
    self._hue = hue
    self._saturation = saturation
    self.brightness = brightness
  }

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)
      
      ColorPoint(color: color)
        .frame(width: 48, height: 48)
        .position(Self.position(from: hue, saturation: saturation, in: frame))
        .gesture(
          DragGesture()
            .onChanged { value in
              updateColor(from: value.location, in: frame)
            }
        )
    }
  }

  // MARK: Functions

  /// Updates the values of the color from the coordinates of the control point.
  /// - Parameters:
  ///   - location: The location of the drag gesture used to compute the new position of the control point.
  ///   - frame: The frame of container view.
  private func updateColor(from location: CGPoint, in frame: CGRect) {
    let radius = frame.width / 2
    /// The vector of the control point relative to the center of the wheel.
    let position = (location - frame.center).limit(radius)

    updateHue(from: position)
    updateSaturation(from: position, in: frame)
  }

  /// Updates the hue of the color from the angle of the control point.
  /// - Parameter position: The coordinates of the control point in the frame.
  private func updateHue(from position: CGPoint) {
    hue = position.normalized.heading
  }

  /// Updates the saturation of the color from the distance of the control point to the center.
  /// - Parameters:
  ///   - position: The coordinates of the control point in the frame.
  ///   - frame: The frame of the container view.
  private func updateSaturation(from position: CGPoint, in frame: CGRect) {
    let radius = frame.width / 2
    saturation = position.magnitude / radius
  }

  /// Computes the position of the control point from the values of the color.
  /// - Parameters:
  ///   - hue: The angle of the color hue.
  ///   - saturation: The value of the saturation.
  ///   - frame: The frame that contains the control point.
  /// - Returns: The coordinates of the control point.
  private static func position(from hue: Angle, saturation: CGFloat, in frame: CGRect) -> CGPoint {
    let radius = frame.width / 2

    return CGPoint(
      angle: hue,
      radius: saturation * radius,
      center: frame.center
    )
  }
}
