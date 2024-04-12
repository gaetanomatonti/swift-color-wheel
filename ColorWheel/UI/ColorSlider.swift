//
//  ColorSlider.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/04/24.
//

import SwiftUI
import Vectors

struct ColorSlider<Value>: View where Value: PercentageRepresentable {
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
  
  private var minimum: Value {
    range.lowerBound
  }

  private var maximum: Value {
    range.upperBound
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

enum ColorSliderGrabberStyle: EnvironmentKey {
  static var defaultValue: AnyShapeStyle = AnyShapeStyle(Color.blue)
}

extension EnvironmentValues {
  var colorSliderGrabberStyle: AnyShapeStyle {
    get {
      self[ColorSliderGrabberStyle.self]
    }
    set {
      self[ColorSliderGrabberStyle.self] = newValue
    }
  }
}

extension View {
  func colorSliderGrabberStyle(_ style: some ShapeStyle) -> some View {
    environment(\.colorSliderGrabberStyle, AnyShapeStyle(style))
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

protocol PercentageRepresentable: Comparable {
  func percentage(in range: ClosedRange<Self>) -> Double

  static func value(from percentage: Double, in range: ClosedRange<Self>) -> Self
}

extension PercentageRepresentable where Self: BinaryFloatingPoint {
  func percentage(in range: ClosedRange<Self>) -> Double {
    Double((self - range.lowerBound) / (range.upperBound - range.lowerBound))
  }

  static func value(from percentage: Double, in range: ClosedRange<Self>) -> Self {
    max(range.lowerBound, min(Self(percentage) * range.upperBound, range.upperBound))
  }
}

extension CGFloat: PercentageRepresentable {}

extension Float: PercentageRepresentable {}
extension Double: PercentageRepresentable {}

extension Angle: PercentageRepresentable {
  func percentage(in range: ClosedRange<Angle>) -> Double {
    Double((self.degrees - range.lowerBound.degrees) / (range.upperBound.degrees - range.lowerBound.degrees))
  }

  static func value(from percentage: Double, in range: ClosedRange<Angle>) -> Angle {
    let degrees = max(range.lowerBound.degrees, min(percentage * range.upperBound.degrees, range.upperBound.degrees))
    return .degrees(degrees)
  }
}

extension ClosedRange where Bound: PercentageRepresentable {
  func value(from percentage: Double) -> Bound {
    Bound.value(from: percentage, in: self)
  }
}
