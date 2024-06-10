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

    init(value: Binding<Value>, range: ClosedRange<Value>) {
      self._value = value
      self.range = range
    }

    // MARK: - Body

    var body: some View {
      GeometryReader { geometry in
        let localFrame = geometry.frame(in: .local)
        let frame = localFrame.insetBy(dx: localFrame.height / 2, dy: .zero)
        
        Circle()
          .fill(style)
          .stroke(.thinMaterial, lineWidth: 4)
          .position(Self.position(in: frame, for: value.percentage(in: range)))
          .gesture(
            DragGesture()
              .onChanged { gesture in
                updateValue(for: gesture.location, in: frame)
              }
          )
      }
    }

    // MARK: - Functions

    /// Updates the selected value from the coordinates of the grabber.
    /// - Parameters:
    ///   - location: The location of the drag gesture used to position the grabber.
    ///   - frame: The frame of the container view.
    func updateValue(for location: CGPoint, in frame: CGRect) {
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
