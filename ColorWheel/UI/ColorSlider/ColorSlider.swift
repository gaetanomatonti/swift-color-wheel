//
//  ColorSlider.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/04/24.
//

import SwiftUI
import Vectors

struct ColorSlider<Value>: View where Value: PercentageConvertible {

  // MARK: - Constants

  /// The height of the slider.
  private let height: CGFloat = 48

  // MARK: - Stored Properties

  /// The range of values allowed in the slider.
  let range: ClosedRange<Value>

  /// The value of the slider.
  @Binding var value: Value

  // MARK: - Computed Properties

  @Environment(\.backgroundStyle) var backgroundStyle

  /// The shape of the slider track.
  private var shape: some Shape {
    RoundedRectangle(cornerRadius: 24, style: .continuous)
  }

  /// The radius of the grabber.
  private var grabberRadius: CGFloat {
    height / 2
  }

  // MARK: - Init

  init(value: Binding<Value>, range: ClosedRange<Value> = 0...1) {
    self._value = value
    self.range = range
  }

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        shape
          .fill(backgroundStyle ?? AnyShapeStyle(.background))
          .stroke(.thinMaterial, lineWidth: 2)
          .frame(width: geometry.size.width)
        
        Grabber(in: geometry.frame(in: .local), value: $value, range: range)
      }
    }
    .frame(height: 48)
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
