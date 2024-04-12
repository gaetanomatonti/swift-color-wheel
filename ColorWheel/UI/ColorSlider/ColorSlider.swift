//
//  ColorSlider.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/04/24.
//

import SwiftUI
import Vectors

struct ColorSlider<Value>: View where Value: PercentageConvertible {
  private let height: CGFloat = 48
    
  /// The value of the slider.
  @Binding var value: Value
  
  /// The position of the grabber.
  @State private var position: CGPoint = .zero
  
  @Environment(\.backgroundStyle) var backgroundStyle
    
  private var shape: some Shape {
    RoundedRectangle(cornerRadius: 24, style: .continuous)
  }
  
  private var grabberRadius: CGFloat {
    height / 2
  }
  
  private var percentage: CGFloat {
    value.percentage(in: range)
  }
  
  let range: ClosedRange<Value>
  
  init(value: Binding<Value>, range: ClosedRange<Value> = 0...1) {
    self._value = value
    self.range = range
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        shape
          .fill(backgroundStyle ?? AnyShapeStyle(.background))
          .stroke(.thinMaterial, lineWidth: 2)
          .frame(width: geometry.size.width)
        
        Grabber()
          .position(position)
          .gesture(
            DragGesture()
              .onChanged { gesture in
                updateValue(for: gesture.location, in: geometry.frame(in: .local))
              }
          )
          .onChange(of: value) { oldValue, newValue in
            position = grabberPosition(in: geometry.frame(in: .local))
          }
          .onAppear {
            position = grabberPosition(in: geometry.frame(in: .local))
          }
      }
    }
    .frame(height: 48)
  }
  
  func updateValue(for location: CGPoint, in rect: CGRect) {
    let percentage = location.x / trackRect(in: rect).width
    value = range.value(from: percentage)
  }
  
  func trackRect(in rect: CGRect) -> CGRect {
    rect.insetBy(dx: grabberRadius, dy: .zero)
  }
  
  func grabberPosition(in rect: CGRect) -> CGPoint {
    let trackRect = trackRect(in: rect)
    
    return CGPoint(
      x: trackRect.minX + trackRect.width * percentage,
      y: rect.midY
    )
  }
}

extension ColorSlider {
  struct Grabber: View {
    @Environment(\.colorSliderGrabberStyle) var grabberStyle

    var body: some View {
      Circle()
        .fill(grabberStyle)
        .stroke(.thinMaterial, lineWidth: 4)
    }
  }
}

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
