//
//  ContentView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 07/03/24.
//

import SwiftUI

/// A view that displays a HSB (Hue-Saturation-Brightness) color wheel.
struct ColorWheel: View {

  // MARK: - Stored Properties

  /// The hue of the color.
  @Binding var hue: Angle

  /// The saturation of the color.
  @Binding var saturation: Double

  /// The selected color harmony scheme.
  let scheme: Scheme

  // MARK: - Computed Properties

  /// The additional colors in the current harmony color scheme.
  private var colors: [HSB] {
    scheme.colors(from: hue, saturation: saturation)
  }

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)

      ControlPoint(
        hue: $hue,
        saturation: $saturation,
        frame: frame
      )

      ForEach(colors) { color in
        ColorPoint(color: color.color)
          .frame(width: 32, height: 32)
          .position(position(for: color, in: frame))
          .transition(.scale.combined(with: .blurReplace))
      }
    }
    .aspectRatio(contentMode: .fit)
    .background {
      colorWheel
    }
    .animation(.snappy, value: scheme)
  }

  // MARK: - Subviews

  private var colorWheel: some View {
    Circle()
      .fill(ShaderLibrary.colorWheel(.boundingRect))
      .stroke(.regularMaterial, lineWidth: 4)
      .background {
        Circle()
          .fill(ShaderLibrary.colorWheel(.boundingRect))
          .blur(radius: 60)
          .opacity(0.4)
      }
  }

  /// Computes the coordinates of the color in the polar coordinates of the passed rectangle.
  /// - Parameters:
  ///   - color: The color to position on the color wheel.
  ///   - rect: The rectangle in which to position the color.
  /// - Returns: The coordinates of the color in the passed rectangle.
  private func position(for color: HSB, in rect: CGRect) -> CGPoint {
    CGPoint(angle: color.hue, radius: color.saturation * rect.width / 2, center: rect.center)
  }
}

// MARK: - Previews

#Preview {
  ColorWheel(
    hue: .constant(.zero),
    saturation: .constant(1),
    scheme: .triad
  )
  .padding(48)
}
