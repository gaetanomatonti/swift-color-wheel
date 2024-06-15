//
//  MeshVerticesConfigurationView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation
import SwiftUI

/// A view that displays the control points to edit the grid of a mesh.
struct MeshVerticesConfigurationView: View {

  // MARK: - Stored Properties

  /// The grid that represents the mesh.
  @Bindable var grid: MeshGrid

  // MARK: - Body

  var body: some View {
    ForEach(grid.flattenedVertices) { vertex in
      MeshVertexControlPoint(vertex: vertex)
        .transition(.opacity.combined(with: .blurReplace))
        .environment(\.areGridEdgesLocked, grid.areEdgesLocked)
        .environment(\.areGridCornersLocked, grid.areCornersLocked)
    }
  }
}
