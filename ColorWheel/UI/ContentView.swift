//
//  ContentView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 09/03/24.
//

import SwiftUI

/// The main view of the app.
struct ContentView: View {

  // MARK: - Stored Properties

  /// The hue of the main color.
  @State private var hue: Angle = .zero

  /// The saturation of the main color.
  @State private var saturation: Double = 1.0

  /// The brightness of the main color.
  @State private var brightness: Double = 1.0

  /// The selected color harmony scheme.
  @State private var scheme: Scheme = .monochromatic
  
  // MARK: - Computed Properties

  /// The colors selected by the harmony scheme.
  var colors: [HSB] {
    var colors = scheme.colors(from: hue, saturation: saturation, brightness: brightness)
    colors.append(HSB(id: 0, hue: hue, saturation: saturation, brightness: brightness))

    return colors.sorted { $0.hue < $1.hue }
  }

  // MARK: - Body

  var body: some View {
    VStack(spacing: 48) {
      GradientPalette(colors: colors)

      ColorWheel(
        hue: $hue.absolute,
        saturation: $saturation,
        brightness: $brightness,
        scheme: scheme
      )
      
      ColorSlider(value: $hue.absolute, range: .zero...Angle(degrees: 360))
        .colorSliderTrackStyle(ShaderLibrary.hue(.boundingRect))
        .colorSliderGrabberStyle(Color(hue: hue, saturation: 1, brightness: 1))
      
      ColorSlider(value: $saturation)
        .colorSliderTrackStyle(
          .linearGradient(
            colors: [.white, Color(hue: hue, saturation: 1, brightness: 1)],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .colorSliderGrabberStyle(.white)
      
      ColorSlider(value: $brightness)
        .colorSliderTrackStyle(
          .linearGradient(
            colors: [.black, Color(hue: hue, saturation: 1, brightness: 1)],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .colorSliderGrabberStyle(.white)
      
      Picker("Color Scheme", selection: $scheme) {
        ForEach(Scheme.allCases, id: \.self) { scheme in
          Text(scheme.title)
            .tag(scheme.rawValue)
        }
      }
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 48)
  }
}

// MARK: - Previews

#Preview {
  ContentView()
}
