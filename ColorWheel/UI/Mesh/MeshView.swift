//
//  MeshView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation
import SwiftUI

/// A view that displays an interactive mesh canvas.
struct MeshView: View {

  // MARK: - Stored Properties

  /// The grid that represents the mesh.
  @State private var grid = MeshGrid(with: .rainbow(columns: 3, rows: 3))

  /// Whether the mesh vertices configuration is visible in the canvas.
  ///
  /// Setting this to true, allows interacting with the vertices.
  @State private var isMeshVerticesConfigurationVisible = false

  // MARK: - Body

  var body: some View {
    MeshCanvasView(
      grid: grid,
      isMeshVerticesConfigurationVisible: $isMeshVerticesConfigurationVisible
    )
    .padding(32)
    .toolbar {
      ToolbarItem(placement: .navigation) {
        Toggle(isOn: $isMeshVerticesConfigurationVisible.animation(.snappy)) {
          Label("Edit mesh", systemImage: "circle.grid.3x3")
        }
        .toggleStyle(.button)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
      }
    }
  }
}
