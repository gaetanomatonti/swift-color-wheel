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

  /// The selected color harmony scheme.
  @Binding var scheme: Scheme

  /// The hue of the color.
  @State private var hue: Angle = .zero

  /// The saturation of the color.
  @State private var saturation: Double = 1

  // MARK: - Computed Properties

  /// The additional colors in the current harmony color scheme.
  var colors: [HSB] {
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
        Circle()
          .fill(color.color)
          .stroke(.thinMaterial, lineWidth: 2)
          .frame(width: 32, height: 32)
          .position(color.position(in: frame))
          .transition(.scale.combined(with: .blurReplace))
      }
    }
    .aspectRatio(contentMode: .fit)
    .background {
      colorWheel
    }
    .animation(.bouncy, value: scheme)
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
}

// MARK: - Previews

#Preview {
  ColorWheel(scheme: .constant(.complementary))
    .padding(48)
}
