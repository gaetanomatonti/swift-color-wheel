//
//  MeshView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 11/06/24.
//

import SwiftUI
import UIKit

/// A view that displays colors in a color scheme as an animated mesh gradient.
@available(iOS 18.0, *)
struct MeshView: View {
  
  // MARK: - Stored Properties

  @Environment(\.displayScale) var displayScale

  /// The number of columns in the grid.
  @State private var columns: Int = 3

  /// The number of rows in the grid.
  @State private var rows: Int = 3

  /// The vertices of the mesh.
  @State private var vertices: [[MeshVertex]] = [
    [
      MeshVertex(
        x: 0.0,
        y: 0.0,
        color: HSB(hue: .degrees(0), saturation: 1, brightness: 1)
      ),
      MeshVertex(
        x: 0.5,
        y: 0.0,
        color: HSB(hue: .degrees(45), saturation: 1, brightness: 1)
      ),
      MeshVertex(
        x: 1.0,
        y: 0.0,
        color: HSB(hue: .degrees(90), saturation: 1, brightness: 1)
      )
    ],
    [
      MeshVertex(
        x: 0.0,
        y: 0.5,
        color: HSB(hue: .degrees(315), saturation: 1, brightness: 1)
      ),
      MeshVertex(
        x: 0.5,
        y: 0.5,
        color: HSB(hue: .degrees(0), saturation: 0, brightness: 1)
      ),
      MeshVertex(
        x: 1.0,
        y: 0.5,
        color: HSB(hue: .degrees(135), saturation: 1, brightness: 1)
      )
    ],
    [
      MeshVertex(
        x: 0.0,
        y: 1.0,
        color: HSB(hue: .degrees(270), saturation: 1, brightness: 1)
      ),
      MeshVertex(
        x: 0.5,
        y: 1.0,
        color: HSB(hue: .degrees(225), saturation: 1, brightness: 1)
      ),
      MeshVertex(
        x: 1.0,
        y: 1.0,
        color: HSB(hue: .degrees(180), saturation: 1, brightness: 1)
      )
    ],
  ]

  /// Whether the configuration sheet is presented.
  @State private var isConfigurationPresented = false

  /// Whether the mesh configuration is enabled.
  ///
  /// Setting this property to true, allows manipulating the vertices of the mesh.
  @State private var isMeshConfigurationEnabled = false

  // MARK: - Computed Properties

  var _flattenedVertices: [MeshVertex] {
    vertices
      .flatMap { $0 }
  }

  var simdVertices: [SIMD2<Float>] {
    _flattenedVertices
      .map(\.simd)
  }

  var _colors: [Color] {
    _flattenedVertices
      .map(\.color)
  }

  // MARK: - Body

  var body: some View {
    ZStack {
      mesh
        .clipShape(.rect(cornerRadius: isMeshConfigurationEnabled ? 24 : .zero))

      if isMeshConfigurationEnabled {
        ForEach(_flattenedVertices) { vertex in
          MeshVertexControlPoint(vertex: vertex)
            .transition(.opacity.combined(with: .blurReplace))
        }
      }
    }
    .ignoresSafeArea(.all, edges: isMeshConfigurationEnabled ? [] : .all)
    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    .padding(isMeshConfigurationEnabled ? 48 : .zero)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          withAnimation(.snappy) {
            isMeshConfigurationEnabled.toggle()
          }
        } label: {
          Label("Edit grid", systemImage: "circle.grid.3x3")
        }
      }

      ToolbarItem(placement: .topBarTrailing) {
        ShareLink(item: prepareForExport(), preview: SharePreview("Wallpaper", image: prepareForExport()))
      }
    }
    .onChange(of: columns) { oldValue, newValue in
      updateColumns(newValue)
    }
    .onChange(of: rows) { oldValue, newValue in
      updateRows(newValue)
    }
  }

  // MARK: - Subviews

  /// The view that displays the mesh gradient.
  private var mesh: some View {
    MeshGradient(
      width: vertices[0].count,
      height: vertices.count,
      points: simdVertices,
      colors: _colors
    )
  }

  // MARK: - Functions

  func updateColumns(_ value: Int) {
    // TODO
  }

  func updateRows(_ value: Int) {
    // TODO
  }

  /// Creates an oscillating value in the specified range.
  func sin(_ value: Double, in range: ClosedRange<Float>) -> Float {
    let x = Float(sinl(value) + 1) / 2
    return range.lowerBound + x * (range.upperBound - range.lowerBound)
  }

  /// Creates an oscillating value in the specified range.
  func cos(_ value: Double, in range: ClosedRange<Float>) -> Float {
    let x = Float(cosl(value) + 1) / 2
    return range.lowerBound + x * (range.upperBound - range.lowerBound)
  }

  /// Prepares an image of the mesh for export.
  func prepareForExport() -> Image {
    let renderer = ImageRenderer(
      content: mesh
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 2048, height: 2048)
    )

    guard let image = renderer.uiImage else {
      return Image("")

    }

    return Image(uiImage: image)
  }
}

// MARK: - Previews

@available(iOS 18.0, *)
#Preview {
  NavigationStack {
    MeshView()
  }
}
