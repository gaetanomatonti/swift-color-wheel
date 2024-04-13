//
//  ColorSlider.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/04/24.
//

import SwiftUI
import Vectors

/// A slider component to select values in a closed range.
struct ColorSlider<Value>: View where Value: PercentageConvertible {

  // MARK: - Constants

  /// The height of the slider.
  private let height: CGFloat = 48

  // MARK: - Stored Properties

  /// The range of values allowed in the slider.
  let range: ClosedRange<Value>

  /// The value of the slider.
  @Binding var value: Value

  // MARK: - Init

  init(value: Binding<Value>, range: ClosedRange<Value> = 0...1) {
    self._value = value
    self.range = range
  }

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)

      ZStack {
        Track(frame: frame)

        Grabber(in: frame, value: $value, range: range)
      }
    }
    .frame(height: height)
  }
}

// MARK: - Previews

#if DEBUG
#Preview {
  struct Wrapped: View {
    @State private var progress: Double = .zero
    
    var body: some View {
      ColorSlider(value: $progress)
        .padding()
    }
  }
  
  return Wrapped()
    .backgroundStyle(ShaderLibrary.hue(.boundingRect))
}
#endif
