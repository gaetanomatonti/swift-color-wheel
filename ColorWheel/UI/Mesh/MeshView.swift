//
//  MeshView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/06/24.
//

import SwiftUI

/// A view that displays colors in a color scheme as an animated mesh gradient.
@available(iOS 18.0, *)
struct MeshView: View {
  
  // MARK: - Stored Properties

  @Environment(\.displayScale) private var displayScale

  /// The grid displayed in the mesh.
  @State private var grid = MeshGrid(columns: 3, rows: 3)

  /// Whether the grid configuration sheet is presented.
  ///
  /// Setting this property to true, allows setting the columns and rows in the grid.
  @State private var isGridConfigurationEnabled = false

  /// Whether the mesh configuration is enabled.
  ///
  /// Setting this property to true, allows manipulating the vertices of the mesh.
  @State private var isMeshConfigurationEnabled = false

  // MARK: - Body

  var body: some View {
    ZStack {
      mesh
        .clipShape(.rect(cornerRadius: isMeshConfigurationEnabled ? 24 : .zero))

      if isMeshConfigurationEnabled {
        ForEach(grid.flattenedVertices) { vertex in
          MeshVertexControlPoint(vertex: vertex)
            .transition(.opacity.combined(with: .blurReplace))
            .environment(\.areGridEdgesLocked, grid.areEdgesLocked)
            .environment(\.areGridCornersLocked, grid.areCornersLocked)
        }
      }
    }
    .ignoresSafeArea(.all, edges: isMeshConfigurationEnabled ? [] : .all)
    #if !os(macOS)
    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    #endif
    .padding(isMeshConfigurationEnabled ? 48 : .zero)
    .toolbar {
      ToolbarItem(placement: .navigation) {
        Toggle(isOn: $isMeshConfigurationEnabled.animation(.snappy)) {
          Label("Edit mesh", systemImage: "circle.grid.3x3")
        }
        .toggleStyle(.button)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
      }

      ToolbarItem(placement: .navigation) {
        Toggle(isOn: $isGridConfigurationEnabled.animation(.snappy)) {
          Label("Edit grid", systemImage: "slider.horizontal.3")
        }
        .toggleStyle(.button)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .popover(isPresented: $isGridConfigurationEnabled) {
          MeshConfigurationView(
            columns: $grid.columns,
            rows: $grid.rows,
            areCornersLocked: $grid.areCornersLocked,
            areEdgesLocked: $grid.areEdgesLocked
          )
          #if os(iOS)
          .frame(minWidth: 300, minHeight: 300)
          .presentationCompactAdaptation(.popover)
          #endif
        }
      }

      ToolbarItem(placement: .navigation) {
        ShareLink(item: prepareForExport(), preview: SharePreview("Wallpaper", image: prepareForExport()))
          .buttonStyle(.bordered)
          .buttonBorderShape(.circle)
      }
    }
    .onChange(of: grid.columns) { oldValue, newValue in
      if oldValue < newValue {
        grid.addColumn()
      } else {
        grid.removeColumn()
      }
    }
    .onChange(of: grid.rows) { oldValue, newValue in
      if oldValue < newValue {
        grid.addRow()
      } else {
        grid.removeRow()
      }
    }
  }

  // MARK: - Subviews

  /// The view that displays the mesh gradient.
  private var mesh: some View {
    MeshGradient(
      width: grid.columns,
      height: grid.rows,
      points: grid.vertices,
      colors: grid.colors
    )
  }

  // MARK: - Functions

  /// Prepares an image of the mesh for export.
  func prepareForExport() -> Image {
    let renderer = ImageRenderer(
      content: mesh
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 2048, height: 2048)
    )

    #if os(macOS)
    guard let image = renderer.nsImage else {
      return Image("")
    }
    
    return Image(nsImage: image)
    #else
    guard let image = renderer.uiImage else {
      return Image("")
    }

    return Image(uiImage: image)
    #endif
  }
}

// MARK: - Previews

@available(iOS 18.0, *)
#Preview {
  NavigationStack {
    MeshView()
  }
}
