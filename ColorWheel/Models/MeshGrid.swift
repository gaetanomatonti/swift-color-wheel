//
//  MeshGrid.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation
import SwiftUI

/// An object that represents a grid of vertices in a mesh.
@Observable
class MeshGrid {

  // MARK: - Stored Properties

  /// The columns in the mesh matrix.
  var columns: Int

  /// The rows in the mesh matrix.
  var rows: Int

  /// Whether the edges of the matrix are locked, and cannot be moved on their perpendicular axis.
  ///
  /// When edges are locked, vertices on the edges can only be moved on their parallel axis.
  /// For instance, vertices on the leading and trailing columns of the matrix can only move vertically,
  /// while vertices on the top and bottom rows can only move horizontally.
  var areEdgesLocked = true

  /// Whether the corners of the matrix are locked.
  ///
  /// When corners are locked, they cannot be moved from their original position, maintaining the overall shape of the matrix.
  var areCornersLocked = true

  /// The aspect ratio of the mesh.
  var aspectRatio: AspectRatio

  /// The matrix of vertices that make up the mesh.
  private(set) var matrix: [[MeshVertex]]

  // MARK: - Computed Properties

  var flattenedVertices: [MeshVertex] {
    matrix
      .flatMap { $0 }
  }

  var vertices: [SIMD2<Float>] {
    matrix
      .flatMap { $0 }
      .map(\.simd)
  }

  var colors: [Color] {
    matrix
      .flatMap { $0 }
      .map(\.color)
  }

  /// An instance of an helper to convert columns and rows indices to an array index, and vice versa.
  private var helper: GridHelper {
    GridHelper(columns: columns, rows: rows)
  }

  // MARK: - Init

  init(columns: Int, rows: Int, aspectRatio: AspectRatio = .square) {
    self.columns = columns
    self.rows = rows
    let generatedVertices = MeshGenerator.rainbow(columns: columns, rows: rows).vertices
    self.matrix = generatedVertices
    self.aspectRatio = aspectRatio
  }

  init(with generator: MeshGenerator, aspectRatio: AspectRatio = .square) {
    self.columns = generator.columns
    self.rows = generator.rows
    self.matrix = generator.vertices
    self.aspectRatio = aspectRatio
  }

  // MARK: - Functions

  /// Updates the mesh from the specified `MeshPreset`.
  func update(with preset: MeshPreset) {
    let generator = preset.generator
    matrix = generator.vertices
    columns = generator.columns
    rows = generator.rows
  }
}

// MARK: - Environment

extension EnvironmentValues {
  /// Whether the corners of the matrix are locked.
  @Entry var areGridCornersLocked = false

  /// Whether the edges of the matrix are locked, and cannot be moved on their perpendicular axis.
  @Entry var areGridEdgesLocked = false
}
