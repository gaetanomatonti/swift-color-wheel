//
//  MeshCanvasView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import SwiftUI

/// A view that displays a mesh gradient and vertices customization.
struct MeshCanvasView: View {

  // MARK: - Stored Properties

  /// The grid that represents the mesh.
  @Bindable var grid: MeshGrid

  /// Whether the mesh vertices configuration is visible in the canvas.
  @Binding var isMeshVerticesConfigurationVisible: Bool

  // MARK: - Body

  var body: some View {
    MeshGradientView(grid: grid)
      .overlay {
        if isMeshVerticesConfigurationVisible {
          MeshVerticesConfigurationView(grid: grid)
        }
      }
  }
}
