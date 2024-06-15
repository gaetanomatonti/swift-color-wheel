//
//  MeshGradientView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import SwiftUI

struct MeshGradientView: View {
  @Bindable var grid: MeshGrid

  var body: some View {
    MeshGradient(
      width: grid.columns,
      height: grid.rows,
      points: grid.vertices,
      colors: grid.colors
    )
    .aspectRatio(grid.aspectRatio.value, contentMode: .fit)
  }
}
