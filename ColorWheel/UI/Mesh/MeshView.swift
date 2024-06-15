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

  /// The selected preset to generate the mesh.
  @State private var preset: MeshPreset

  /// The grid that represents the mesh.
  @State private var grid: MeshGrid

  /// Whether the mesh vertices configuration is visible in the canvas.
  ///
  /// Setting this to true, allows interacting with the vertices.
  @State private var isMeshVerticesConfigurationVisible: Bool

  /// Whether the configurator is visible.
  @State private var isConfiguratorVisible: Bool

  // MARK: - Init

  init(preset: MeshPreset = .rainbow) {
    self.preset = preset
    self.grid = MeshGrid(with: preset.generator)
    self.isMeshVerticesConfigurationVisible = false
    self.isConfiguratorVisible = false
  }

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
          Label("Edit grid", systemImage: "circle.grid.3x3")
        }
        .toggleStyle(.button)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
      }

      ToolbarItem(placement: .navigation) {
        Toggle(isOn: $isConfiguratorVisible) {
          Label("Edit mesh", systemImage: "slider.horizontal.3")
        }
        .toggleStyle(.button)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
      }

      ToolbarItem(placement: .bottomBar) {
        Button {
          grid.randomize(from: preset)
        } label: {
          Label("Randomize", systemImage: "dice")
        }
      }
    }
    .sheet(isPresented: $isConfiguratorVisible) {
      NavigationStack {
        MeshConfiguratorView(selectedPreset: $preset, aspectRatio: $grid.aspectRatio)
      }
      .presentationDetents([.medium, .large])
    }
    .onChange(of: preset) { oldValue, newValue in
      grid.update(with: newValue)
    }
  }
}
