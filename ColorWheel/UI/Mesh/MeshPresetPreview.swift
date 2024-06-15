//
//  MeshPresetPreview.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import SwiftUI

/// A view that displays a preview for a mesh gradient preset.
struct MeshPresetPreview: View {

  // MARK: - Stored Properties

  /// The preset displayed in the preview.
  let preset: MeshPreset

  /// Whether the preset is currently selected.
  let isSelected: Bool

  // MARK: - Computed Properties

  /// The grid that represents the mesh.
  private var grid: MeshGrid {
    MeshGrid(with: preset.generator, aspectRatio: .init("4:3", value: 4.0 / 3.0))
  }

  /// The shape of the preview.
  private var shape: some InsettableShape {
    RoundedRectangle(cornerRadius: 8)
  }

  // MARK: - Body

  var body: some View {
    VStack(spacing: 4) {
      MeshGradientView(grid: grid)
        .clipShape(.containerRelative)
        .frame(width: 96, height: 96 / grid.aspectRatio.value)
        .overlay {
          if isSelected {
            ContainerRelativeShape()
              .stroke(.tint, lineWidth: 2)
              .transition(.blurReplace)
          }
        }
        .containerShape(shape)

      Text(preset.label)
        .font(.caption)
        .foregroundStyle(.secondary)
    }
  }
}

// MARK: - Previews

#Preview("Rainbow", traits: .sizeThatFitsLayout) {
  MeshPresetPreview(preset: .rainbow, isSelected: false)
}

#Preview("Aurora", traits: .sizeThatFitsLayout) {
  MeshPresetPreview(preset: .aurora, isSelected: true)
}
