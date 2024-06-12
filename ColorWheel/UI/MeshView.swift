//
//  MeshView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/06/24.
//

import SwiftUI
import UIKit

/// A view that displays colors in a color scheme as an animated mesh gradient.
@available(iOS 18.0, *)
struct MeshView: View {
  
  // MARK: - Stored Properties

  /// The reference date to compute the interval of the animation.
  private let startDate = Date()

  /// The hue of the main color.
  @State private var hue: Angle = .zero

  /// The saturation of the main color.
  @State private var saturation: Double = 1.0

  /// The brightness of the main color.
  @State private var brightness: Double = 1.0

  /// The selected color harmony scheme.
  @State private var scheme: Scheme = .analogous

  /// Whether the color wheel should be visible.
  @State private var isWheelVisible = false

  // MARK: - Computed Properties

  private let seedOne = Double.random(in: 0...1)

  private let seedTwo = Double.random(in: 0...1)

  private let seedThree = Double.random(in: 0...1)

  private var hsbColors: [HSB] {
    scheme.colors(from: hue, saturation: saturation, brightness: brightness) + [
      HSB(id: 0, hue: hue, saturation: saturation, brightness: brightness)
    ]
  }

  private var colors: [Color] {
    hsbColors
      .sorted { $0.hue < $1.hue }
      .map(\.color)
  }

  // MARK: - Body

  var body: some View {
    ZStack {
      TimelineView(.animation) { context in
        let time = context.date
        let interval = startDate.distance(to: time) / 2

        MeshGradient(
          width: colors.count + 2,
          height: 3,
          points: [
            [0, 0], [0.25, 0], [0.5, 0], [0.75, 0], [1, 0],
            [0, 0.5],
            [cos(interval * seedOne, in: 0.05...0.25), cos(interval * seedOne, in: 0.15...0.85)],
            [sin(interval * seedTwo, in: 0.35...0.65), sin(interval * seedTwo, in: 0.15...0.85)],
            [cos(interval * seedThree, in: 0.75...0.95), cos(interval * seedThree, in: 0.15...0.85)],
            [1, 0.5],
            [0, 1], [0.25, 1], [0.5, 1], [0.75, 1], [1, 1],
          ],
          colors: [.black, .black, .black, .black, .black, .black] + colors + [.black, .black, .black, .black, .black, .black]
        )
      }

      if isWheelVisible {
        ColorWheel(hue: $hue, saturation: $saturation, brightness: $brightness, scheme: scheme)
          .padding(64)
          .transition(.scale.combined(with: .blurReplace))
      }
    }
    .ignoresSafeArea()
    .overlay(alignment: .bottomTrailing) {
      Button {
        isWheelVisible.toggle()
      } label: {
        Image(systemName: "paintpalette")
      }
      .buttonStyle(.bordered)
      .buttonBorderShape(.circle)
      .foregroundStyle(.regularMaterial)
      .scenePadding()
    }
    .animation(.snappy, value: isWheelVisible)
  }

  /// Creates an oscillating value in the specified range.
  func sin(_ value: Double, in range: ClosedRange<Float>) -> Float {
    let x = Float(sinl(value) + 1) / 2
    return range.lowerBound + x * (range.upperBound - range.lowerBound)
  }

  /// Creates an oscillating value in the specified range.
  func cos(_ value: Double, in range: ClosedRange<Float>) -> Float {
    let x = Float(cosl(value) + 1) / 2
    return range.lowerBound + x * (range.upperBound - range.lowerBound)
  }
}

// MARK: - Previews

@available(iOS 18.0, *)
#Preview {
  NavigationStack {
    MeshView()
  }
}
