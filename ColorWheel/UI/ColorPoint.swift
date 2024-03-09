//
//  ColorPoint.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import SwiftUI

/// A view that displays a single color point.
struct ColorPoint: View {

  /// The color displayed in the view.
  let color: Color

  // MARK: - Body

  var body: some View {
    Circle()
      .fill(color)
      .stroke(.thinMaterial, lineWidth: 4)
  }
}

#Preview {
  ColorPoint(color: .red)
}
