//
//  MeshConfiguratorView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import SwiftUI

/// A view that allows configuration for a mesh.
struct MeshConfiguratorView: View {

  // MARK: - Stored Properties

  /// The grid that represents the mesh to configure.
  @Bindable var grid: MeshGrid

  /// The range of allowed vertices in the rows and columns of the grid.
  private let verticesRange = 3...6

  // MARK: - Body

  var body: some View {
    Form {
      columnsStepper

      rowsStepper

      aspectRatioPicker
    }
  }

  // MARK: - Subviews

  /// The stepper to control the number of columns in the grid.
  private var columnsStepper: some View {
    Stepper(value: $grid.columns, in: verticesRange) {
      HStack {
        Text("Columns")
        Spacer()
        Text("\(grid.columns)")
      }
    }
  }

  /// The stepper to control the number of rows in the grid.
  private var rowsStepper: some View {
    Stepper(value: $grid.rows, in: verticesRange) {
      HStack {
        Text("Rows")
        Spacer()
        Text("\(grid.rows)")
      }
    }
  }

  /// The picker to select the aspect ratio of the mesh.
  private var aspectRatioPicker: some View {
    Picker("Aspect Ratio", selection: $grid.aspectRatio) {
      ForEach(AspectRatio.availableValues) { aspectRatio in
        Text(aspectRatio.label)
          .tag(aspectRatio)
      }
    }
  }
}

#Preview {
  @Previewable @State var grid = MeshGrid(with: .rainbow(columns: 5, rows: 5))
  MeshConfiguratorView(grid: grid)
}
