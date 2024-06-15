//
//  MeshCanvasView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import SwiftUI

struct MeshCanvasView: View {
  @Bindable var grid: MeshGrid

  @Binding var isMeshVerticesConfigurationVisible: Bool

  var body: some View {
    MeshGradientView(grid: grid)
      .overlay {
        if isMeshVerticesConfigurationVisible {
          MeshVerticesConfigurationView(grid: grid)
        }
      }
  }
}
