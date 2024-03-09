//
//  GradientPalette.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import SwiftUI

/// A view that displays a gradient from a palette of colors.
struct GradientPalette: View {

  // MARK: - Stored Properties

  /// The colors in the gradient.
  let colors: [HSB]

  // MARK: - Body

  var body: some View {
    RoundedRectangle(cornerRadius: 12)
      .fill(
        .linearGradient(colors: colors.map(\.color), startPoint: .leading, endPoint: .trailing)
      )
      .stroke(.regularMaterial, lineWidth: 4)
      .frame(maxWidth: .infinity)
      .frame(height: 48)
  }
}
