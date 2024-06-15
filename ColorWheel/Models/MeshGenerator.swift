//
//  MeshGenerator.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 14/06/24.
//

import Foundation
import Vectors

/// An object that generates the grid for a mesh gradient.
struct MeshGenerator {

  /// A type that represents a row index.
  typealias Row = Int

  /// A type that represents a column index.
  typealias Column = Int

  /// The closure that creates a vertex from row, and column indices, and a `GridHelper` object.
  typealias VertexProvider = (Row, Column, GridHelper) -> MeshVertex

  // MARK: - Stored Properties

  /// The columns of the grid.
  private let columns: Row

  /// The rows of the grid.
  private let rows: Column

  /// The closure that creates a vertex from row, and column indices, and a `GridHelper` object.
  private var vertexProvider: VertexProvider

  // MARK: - Computed Properties

  /// The vertices generated by the object.
  var vertices: [[MeshVertex]] {
    generateVertices()
  }

  /// The `GridHelper` object to help with grid computations.
  private var helper: GridHelper {
    GridHelper(columns: columns, rows: rows)
  }

  // MARK: - Init

  init(columns: Int, rows: Int, vertexProvider: @escaping VertexProvider) {
    precondition(columns > 1 && rows > 1, "The number of columns and rows must be greater than 1.")

    self.columns = columns
    self.rows = rows
    self.vertexProvider = vertexProvider
  }

  // MARK: - Functions

  /// Generates the vertices of the mesh.
  private func generateVertices() -> [[MeshVertex]] {
    var vertices: [[MeshVertex]] = Array(repeating: [], count: rows)

    for row in 0..<rows {
      for column in 0..<columns {
        let vertex = vertexProvider(row, column, helper)
        vertex.location = helper.location(row, column)
        vertices[row].insert(vertex, at: column)
      }
    }

    return vertices
  }
}

extension MeshGenerator {
  /// A preset grid where the position of the vertices is associated to a hue.
  static func rainbow(columns: Int, rows: Int) -> MeshGenerator {
    MeshGenerator(columns: columns, rows: rows) { row, column, helper in
      let center = CGPoint(x: 0.5, y: 0.5)
      let position = helper.position(for: row, and: column)

      /// The offset position, so that the it falls in the range [-1, 1]
      let offsetPosition = (position - center).normalized

      let hue = atan2(offsetPosition.y, offsetPosition.x)
      let saturation = offsetPosition.magnitude

      let color = HSB(hue: .radians(hue), saturation: saturation, brightness: 1)
      return MeshVertex(position: position, color: color)
    }
  }
}
