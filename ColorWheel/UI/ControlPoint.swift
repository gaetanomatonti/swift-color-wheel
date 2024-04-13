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

  /// The current position of the control point.
  @State private var position: CGPoint

  /// The hue of the currently selected color.
  @Binding private var hue: Angle

  /// The saturation of the currently selected color.
  @Binding private var saturation: Double

  /// The brightness of the currently selected color.
  private let brightness: Double

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

    self.position = Self.position(from: hue.wrappedValue, saturation: saturation.wrappedValue, in: frame)
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

  /// Updates the values of the color from the coordinates of the control point.
  /// - Parameter location: The location of the drag gesture used to compute the new position of the control point.
  private func updateColor(from location: CGPoint) {
    /// The vector of the control point relative to the center of the wheel.
    let position = (location - center).limit(radius)

    updateHue(from: position)
    updateSaturation(from: position)
  }

  /// Updates the hue of the color from the angle of the control point.
  /// - Parameter position: The coordinates of the control point in the frame.
  private func updateHue(from position: CGPoint) {
    hue = position.normalized.heading
  }

  /// Updates the saturation of the color from the distance of the control point to the center.
  /// - Parameter position: The coordinates of the control point in the frame.
  private func updateSaturation(from position: CGPoint) {
    saturation = position.magnitude / radius
  }
  
  /// Updates the position of the control point from the values of the color.
  /// - Parameters:
  ///   - hue: The angle of the color hue.
  ///   - saturation: The value of the saturation.
  private func updatePosition(from hue: Angle, saturation: CGFloat) {
    position = Self.position(from: hue, saturation: saturation, in: frame)
  }

  /// Computes the position of the control point from the values of the color.
  /// - Parameters:
  ///   - hue: The angle of the color hue.
  ///   - saturation: The value of the saturation.
  ///   - frame: The frame that contains the control point.
  /// - Returns: The coordinates of the control point.
  private static func position(from hue: Angle, saturation: CGFloat, in frame: CGRect) -> CGPoint {
    CGPoint(
      angle: hue,
      radius: saturation * frame.width / 2,
      center: frame.center
    )
  }
}
