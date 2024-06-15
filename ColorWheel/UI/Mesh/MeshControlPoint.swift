//
//  MeshControlPoint.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation
import SwiftUI

/// A view that displays a draggable control point that controls color and position selection for a mesh vertex.
struct MeshVertexControlPoint: View {

  // MARK: - Stored Properties

  /// The vertex controlled by the control point.
  @Bindable var vertex: MeshVertex

  /// Whether the user is dragging the control point.
  @State private var isDragging = false

  // MARK: - Computed Properties

  @Environment(\.areGridEdgesLocked) var areEdgesLocked: Bool

  @Environment(\.areGridCornersLocked) var areCornersLocked: Bool

  // MARK: - Body

  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)

      ColorPoint(color: vertex.color)
        .frame(width: 48, height: 48)
        .position(vertexPosition(in: frame))
        #if os(macOS)
        .pointerStyle(isDragging ? .grabActive : .grabIdle) // bug: not updating?
        #endif
        .gesture(
          DragGesture()
            .onChanged { gesture in
              updatePosition(for: vertex.location, from: gesture.location, in: frame)
              isDragging = true
            }
            .onEnded { _ in
              isDragging = false
            }
        )
    }
  }

  // MARK: - Functions

  /// Updates the position of the control point, depending on the location of the vertex.
  ///
  /// If the vertex is either on the corners or edges of the grid, we also check if they should be locked.
  /// In that case, this method does not reposition the control point or does so only on a specific axis.
  ///
  /// - Parameters:
  ///   - vertexLocation: The `VertexLocation` of the vertex.
  ///   - location: The location of the drag gesture.
  ///   - frame: The frame of the container view.
  private func updatePosition(for vertexLocation: VertexLocation, from location: CGPoint, in frame: CGRect) {
    let position = vertexPosition(from: location, in: frame)

    switch vertexLocation {
      case .corner:
        if areCornersLocked {
          break
        } else {
          updatePosition(for: .center, from: location, in: frame)
        }

      case let .edge(axis):
        if areEdgesLocked {
          switch axis {
            case .horizontal:
              vertex.position.x = position.x

            case .vertical:
              vertex.position.y = position.y
          }
        } else {
          updatePosition(for: .center, from: location, in: frame)
        }

      case .center:
        vertex.position = position
    }
  }

  /// Updates the position of the vertex.
  ///
  /// This function converts the location of the point from the coordinate space of the view to the coordinate space of the mesh.
  ///
  /// - Parameters:
  ///   - location: The location of the drag gesture.
  ///   - frame: The frame of the container view.
  private func vertexPosition(from location: CGPoint, in frame: CGRect) -> CGPoint {
    CGPoint(
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
    CGPoint(
      x: vertex.position.x * frame.width,
      y: vertex.position.y * frame.height
    )
  }
}
