//
//  ColorSlider+Grabber.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 13/04/24.
//

import Foundation
import SwiftUI
import Vectors

extension ColorSlider {
  /// A view that displays the component the user grabs to pick values in the slider.
  struct Grabber: View {

    // MARK: - Stored Properties

    /// The position of the grabber in the frame.
    @State private var position: CGPoint

    /// The frame that contains the grabber.
    private let frame: CGRect

    /// The range of values allowed in the slider.
    private let range: ClosedRange<Value>

    // MARK: - Computed Properties

    /// The value of the slider.
    @Binding var value: Value

    @Environment(\.colorSliderGrabberStyle) var style

    /// The percentage of the value in the range.
    private var percentage: CGFloat {
      value.percentage(in: range)
    }

    // MARK: - Init

    init(in frame: CGRect, value: Binding<Value>, range: ClosedRange<Value>) {
      let radius = frame.height / 2
      let trackFrame = frame.insetBy(dx: radius, dy: .zero)
      
      self.frame = trackFrame
      self._value = value
      self.range = range
      self.position = Self.position(in: trackFrame, for: value.wrappedValue.percentage(in: range))
    }

    // MARK: - Body

    var body: some View {
      Circle()
        .fill(style)
        .stroke(.thinMaterial, lineWidth: 4)
        .position(position)
        .gesture(
          DragGesture()
            .onChanged { gesture in
              updateValue(for: gesture.location)
            }
        )
        .onChange(of: value) { oldValue, newValue in
          position = Self.position(in: frame, for: percentage)
        }
    }

    // MARK: - Functions

    /// Updates the selected value from the coordinates of the grabber.
    /// - Parameter location: The location of the drag gesture used to position the grabber.
    func updateValue(for location: CGPoint) {
      let percentage = (location.x - frame.minX) / frame.width
      value = range.value(from: percentage)
    }

    /// Computes the position of the grabber.
    /// - Parameters:
    ///   - frame: The frame that contains the grabber.
    ///   - percentage: The percentage of the selected value, used to correctly position the grabber.
    static func position(in frame: CGRect, for percentage: Double) -> CGPoint {
      CGPoint(
        x: frame.minX + frame.width * percentage,
        y: frame.midY
      )
    }
  }
}
