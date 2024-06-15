//
//  MeshVerticesConfigurationView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation
import SwiftUI

struct MeshVerticesConfigurationView: View {
  @Bindable var grid: MeshGrid

  var body: some View {
    ForEach(grid.flattenedVertices) { vertex in
      MeshVertexControlPoint(vertex: vertex)
        .transition(.opacity.combined(with: .blurReplace))
        .environment(\.areGridEdgesLocked, grid.areEdgesLocked)
        .environment(\.areGridCornersLocked, grid.areCornersLocked)
    }
  }
}
