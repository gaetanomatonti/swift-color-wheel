//
//  ColorPicker.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/06/24.
//

import SwiftUI

/// A view that allows picking a color in HSB format.
struct ColorPicker: View {
  /// The hue of the color.
  @Binding var hue: Angle

  /// The saturation of the color.
  @Binding var saturation: Double

  /// The brightness of the color.
  @Binding var brightness: Double

  var body: some View {
    TabView {
      ColorWheelPicker(hue: $hue, saturation: $saturation, brightness: $brightness)

      SliderColorPicker(hue: $hue, saturation: $saturation, brightness: $brightness)
    }
    .tabViewStyle(.sidebarAdaptable)
  }
}

/// A wheel-based color picker.
///
/// This view displays a color wheel to control hue and saturation of a color, and an additional slider for its brightness.
fileprivate struct ColorWheelPicker: View {
  /// The hue of the color.
  @Binding var hue: Angle

  /// The saturation of the color.
  @Binding var saturation: Double

  /// The brightness of the color.
  @Binding var brightness: Double

  var body: some View {
    VStack(spacing: 16) {
      ColorWheel(hue: $hue, saturation: $saturation, brightness: $brightness, scheme: .monochromatic)
        .padding(24)

      ColorSlider(value: $brightness)
        .colorSliderTrackStyle(
          .linearGradient(
            colors: [.black, Color(hue: hue, saturation: 1, brightness: 1)],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .colorSliderGrabberStyle(.white)
        .padding(.horizontal, 8)
    }
    .padding(24)
  }
}

/// A slider-based color picker.
///
/// This view displays a slider to control each component of the HSB space.
fileprivate struct SliderColorPicker: View {
  /// The hue of the color.
  @Binding var hue: Angle

  /// The saturation of the color.
  @Binding var saturation: Double

  /// The brightness of the color.
  @Binding var brightness: Double

  var body: some View {
    VStack(spacing: 24) {
      GradientPalette(colors: [HSB(hue: hue, saturation: saturation, brightness: brightness)])

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
    }
    .padding(.horizontal, 8)
    .padding(24)
  }
}
