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

  @Environment(\.dismiss) private var dismiss

  /// The selected preset.
  @Binding var selectedPreset: MeshPreset

  /// The selected aspect ratio.
  @Binding var aspectRatio: AspectRatio

  /// The selected amount of columns.
  @State private var columns: Int

  /// The selected amount of rows.
  @State private var rows: Int

  /// The range of allowed vertices in the rows and columns of the grid.
  private let verticesRange = 3...6

  // MARK: - Init

  init(selectedPreset: Binding<MeshPreset>, aspectRatio: Binding<AspectRatio>) {
    self._selectedPreset = selectedPreset
    self._aspectRatio = aspectRatio
    self.columns = selectedPreset.wrappedValue.generator.columns
    self.rows = selectedPreset.wrappedValue.generator.rows
  }

  // MARK: - Body

  var body: some View {
    content
      .onChange(of: selectedPreset) { oldValue, newValue in
        columns = newValue.generator.columns
        rows = newValue.generator.rows
      }
      .navigationTitle("Configuration")
      .toolbarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigation) {
          Button("Done") {
            dismiss()
          }
        }
      }
  }

  // MARK: - Subviews

  #if os(iOS)
  private var content: some View {
    Form {
      Section {
        presetPicker
      }

      Section {
        aspectRatioPicker
      }

      if case .custom = selectedPreset.id {
        Section {
          columnsStepper

          rowsStepper
        }
        .onChange(of: columns) { oldValue, newValue in
          selectedPreset = MeshPreset.custom(columns: newValue, rows: rows)
        }
        .onChange(of: rows) { oldValue, newValue in
          selectedPreset = MeshPreset.custom(columns: columns, rows: newValue)
        }
      }
    }
  }
  #endif

  #if os(macOS)
  private var content: some View {
    VStack {
      Spacer()

      HStack {
        Spacer()

        Form {
          presetPicker

          aspectRatioPicker

          if case .custom = selectedPreset.id {
            Group {
              columnsStepper

              rowsStepper
            }
            .onChange(of: columns) { oldValue, newValue in
              selectedPreset = MeshPreset.custom(columns: newValue, rows: rows)
            }
            .onChange(of: rows) { oldValue, newValue in
              selectedPreset = MeshPreset.custom(columns: columns, rows: newValue)
            }
          }
        }

        Spacer()
      }

      Spacer()
    }
  }
  #endif

  /// The picker to select a mesh preset.
  private var presetPicker: some View {
    HStack(spacing: 16) {
      ForEach(MeshPreset.allCases) { preset in
        Button {
          selectedPreset = preset
        } label: {
          MeshPresetPreview(preset: preset, isSelected: selectedPreset == preset)
        }
        .buttonStyle(.plain)
      }
    }
  }

  /// The stepper to control the number of columns in the grid.
  private var columnsStepper: some View {
    Stepper(value: $columns, in: verticesRange) {
      HStack {
        Text("Columns")
        Spacer()
        Text("\(columns)")
      }
    }
  }

  /// The stepper to control the number of rows in the grid.
  private var rowsStepper: some View {
    Stepper(value: $rows, in: verticesRange) {
      HStack {
        Text("Rows")
        Spacer()
        Text("\(rows)")
      }
    }
  }

  /// The picker to select the aspect ratio of the mesh.
  private var aspectRatioPicker: some View {
    Picker("Aspect Ratio", selection: $aspectRatio) {
      ForEach(AspectRatio.availableValues) { aspectRatio in
        Text(aspectRatio.label)
          .tag(aspectRatio)
      }
    }
  }
}

#Preview {
  @Previewable @State var preset = MeshPreset.rainbow
  @Previewable @State var aspectRatio = AspectRatio.square

  MeshConfiguratorView(selectedPreset: $preset, aspectRatio: $aspectRatio)
}
