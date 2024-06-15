//
//  MeshView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation
import SwiftUI

struct MeshView: View {
  @State private var grid = MeshGrid(with: .rainbow(columns: 3, rows: 3))

  @State private var isMeshVerticesConfigurationVisible = false

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
