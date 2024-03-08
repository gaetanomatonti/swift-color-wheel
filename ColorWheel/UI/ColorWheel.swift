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

  /// The selected color.
  @State private var color: Color = .white

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      ControlPoint(
        color: $color,
        center: geometry.frame(in: .local).center,
        radius: geometry.size.width / 2
      )
    }
    .aspectRatio(contentMode: .fit)
    .background {
      colorWheel
    }
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
  ColorWheel()
    .padding(48)
}
