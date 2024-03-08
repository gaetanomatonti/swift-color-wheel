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

  /// The binding to the currently selected `Color`.
  @Binding private var color: Color

  /// The current position of the control point.
  @State private var position: CGPoint

  /// The center of the circle the control point is positioned in.
  private let center: CGPoint

  /// The radius of the circle the control point is positioned in.
  private let radius: CGFloat

  // MARK: - Computed Properties

  /// The vector of the control point that points to the center of the circle.
  private var toCenter: CGPoint {
    center - position
  }

  /// The hue of the current color.
  private var hue: Angle {
    let normalizedToCenter = toCenter.normalized
    let angle = atan2(normalizedToCenter.y, normalizedToCenter.x) + .pi
    return .radians(angle / (.pi * 2))
  }

  /// The saturation of the current color.
  private var saturation: CGFloat {
    toCenter.magnitude / radius
  }

  // MARK: - Body

  init(color: Binding<Color>, center: CGPoint, radius: CGFloat) {
    self._color = color
    self.position = center
    self.center = center
    self.radius = radius
  }

  // MARK: - Body

  var body: some View {
    Circle()
      .fill(color)
      .stroke(.thinMaterial, lineWidth: 4)
      .frame(width: 48, height: 48)
      .position(position)
      .gesture(
        DragGesture()
          .onChanged { value in
            position = (value.location - center).limit(radius) + center

            color = Color(
              hue: hue.radians,
              saturation: saturation,
              brightness: 1
            )
          }
      )
  }
}
