//
//  ColorWheelApp.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 07/03/24.
//

import SwiftUI

@main
struct ColorWheelApp: App {
  var body: some Scene {
    WindowGroup {
      TabView {
        ContentView()
          .tabItem {
            Label("Picker", systemImage: "paintbrush.pointed")
          }

        if #available(iOS 18, *) {
          MeshView()
            .tabItem {
              Label("Mesh", systemImage: "circle.grid.3x3")
            }
        }
      }
      .tint(.primary)
    }
  }
}
