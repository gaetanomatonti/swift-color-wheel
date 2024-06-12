//
//  MeshVertexControlPoint.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/06/24.
//

import SwiftUI

/// A view that displays a draggable control point that controls color and position selection for a mesh vertex.
struct MeshVertexControlPoint: View {
  /// The vertex controlled by the control point.
  @Bindable var vertex: MeshVertex

  /// Whether the color customization of the vertex is enabled.
  ///
  /// This property controls the presentation of a color picker, allowing picking a color for the vertex.
  @State private var isColorCustomizationEnabled = false

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)

      ColorPoint(color: vertex.color)
        .frame(width: 48, height: 48)
        .position(vertexPosition(in: frame))
        .onTapGesture(count: 2) {
          isColorCustomizationEnabled.toggle()
        }
        .gesture(
          DragGesture()
            .onChanged { value in
              updatePosition(from: value.location, in: frame)
            }
        )
    }
    .sheet(isPresented: $isColorCustomizationEnabled) {
      ColorPicker(hue: $vertex.hsbColor.hue, saturation: $vertex.hsbColor.saturation, brightness: $vertex.hsbColor.brightness)
        .frame(minWidth: 320, minHeight: 440)
    }
  }

  // MARK: - Functions

  /// Updates the position of the vertex.
  ///
  /// This function converts the location of the point from the coordinate space of the view to the coordinate space of the mesh.
  ///
  /// - Parameters:
  ///   - location: The location of the drag gesture.
  ///   - frame: The frame of the container view.
  private func updatePosition(from location: CGPoint, in frame: CGRect) {
    vertex.position = CGPoint(
      x: max(0, min(location.x / frame.width, 1)),
      y: max(0, min(location.y / frame.height, 1))
    )
  }

  /// Returns the position of the control point from the position of the vertex in the mesh.
  ///
  /// This function converts the location of the control point from the mesh coordinate space to the coordinate space of the view.
  ///
  /// - Parameter frame: The frame of the container view.
  /// - Returns: The position of the vertex in the view.
  private func vertexPosition(in frame: CGRect) -> CGPoint {
    let x = vertex.position.x * frame.width
    let y = vertex.position.y * frame.height
    return CGPoint(x: x, y: y)
  }
}