//
//  ColorWheelApp.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 07/03/24.
//

import SwiftUI

@main
struct ColorWheelApp: App {
  @State private var scheme: Scheme = .monochromatic

  var body: some Scene {
    WindowGroup {
      VStack(spacing: 32) {
        ColorWheel(scheme: $scheme)
          .padding(48)

        Picker("Color Scheme", selection: $scheme) {
          ForEach(Scheme.allCases, id: \.self) { scheme in
            Text(scheme.title)
              .tag(scheme.rawValue)
          }
        }
      }
    }
  }
}
