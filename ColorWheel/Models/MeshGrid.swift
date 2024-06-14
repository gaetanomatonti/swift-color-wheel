//
//  MeshGenerator.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 13/06/24.
//

import Foundation
import SwiftUI
import Vectors

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
  var areEdgesLocked = false

  /// Whether the corners of the matrix are locked.
  ///
  /// When corners are locked, they cannot be moved from their original position, maintaining the overall shape of the matrix.
  var areCornersLocked = false

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

  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows
    let generatedVertices = MeshGenerator.rainbow(columns: columns, rows: rows).vertices
    self.matrix = generatedVertices
  }

  // MARK: - Functions

  func addColumn() {
    for row in 0..<rows {
      var i = 0
      var j = matrix[row].count - 1

      var newRow: [MeshVertex] = Array(repeating: MeshVertex(position: .zero, color: .white), count: columns)
      newRow[0] = matrix[row][i]
      newRow[columns - 1] = matrix[row][j]

      while j - i > 0 {
        let iPosition = helper.position(for: row, and: i + 1)
        let iColor = lerp(v1: matrix[row][i].hsbColor, v2: matrix[row][i + 1].hsbColor, t: 1 - iPosition.x)
        newRow[i + 1] = MeshVertex(position: iPosition,color: iColor)

        let jPosition = helper.position(for: row, and: j)
        let jColor = lerp(v1: matrix[row][j - 1].hsbColor, v2: matrix[row][j].hsbColor, t: 1 - jPosition.x)
        newRow[j] = MeshVertex(position: jPosition,color: jColor)

        i += 1
        j -= 1
      }

      matrix[row] = newRow
    }
  }

  func removeColumn() {
    // TODO: Implement (might reuse add)
  }

  func removeColumn(at columnIndex: Int) {
    guard columnIndex > 0 && columnIndex < columns else {
      fatalError("The application only supports inserting between existing columns.")
    }

    let rows = matrix.count

    // Remove the specified row
    for row in 0..<rows {
      matrix[row].remove(at: columnIndex)

      for column in 0..<columns {
        matrix[row][column].position.x = helper.position(for: row, and: column).x

        if column > 0 && column < columns - 1 {
          matrix[row][column - 1].hsbColor = lerp(v1:  matrix[row][column - 1].hsbColor, v2:  matrix[row][column].hsbColor, t: 0.25)
          matrix[row][column].hsbColor = lerp(v1:  matrix[row][column - 1].hsbColor, v2:  matrix[row][column].hsbColor, t: 0.75)
        }
      }
    }
  }

  func addRow() {
    addRow(at: rows / 2)
  }

  func addRow(at rowIndex: Int) {
    let rows = matrix.count
    guard rows > 1 else {
      print("Matrix must have at least two rows.")
      return
    }

    let cols = matrix[0].count
    guard cols > 1 else {
      print("Matrix must have at least two columns.")
      return
    }

    // Adding in between
    let newRow: [MeshVertex] = (0..<cols).map { col in
      let c1 = matrix[rowIndex - 1][col]
      let c2 = matrix[rowIndex][col]
      let c3 = matrix[rowIndex - 1][col]
      let c4 = matrix[rowIndex][col]

      return blerp(c1: c1, c2: c2, c3: c3, c4: c4, tx: 0.5, ty: 0.5)
    }
    matrix.insert(newRow, at: rowIndex)

    // Recalculate positions for all rows to be evenly spaced
    for (rowIndex, _) in matrix.enumerated() {
        for colIndex in 0..<cols {
          matrix[rowIndex][colIndex].position.y = helper.position(for: rowIndex, and: colIndex).y
        }
    }
  }

  func removeRow() {
    removeRow(at: rows / 2)
  }

  func removeRow(at rowIndex: Int) {
    guard rows > 1 else {
      return
    }

    guard rowIndex >= 0 && rowIndex < rows else {
      return
    }

    let rows = matrix.count
    let cols = matrix[0].count

    // Remove the specified row
    matrix.remove(at: rowIndex)

    // Interpolate colors between the row above and the row below
    if rowIndex > 0 && rowIndex < rows - 1 {
        let rowAbove = matrix[rowIndex - 1]
        let rowBelow = matrix[rowIndex]

        for col in 0..<cols {
          matrix[rowIndex - 1][col].hsbColor = lerp(v1: rowAbove[col].hsbColor, v2: rowBelow[col].hsbColor, t: 0.25)
          matrix[rowIndex][col].hsbColor = lerp(v1: rowAbove[col].hsbColor, v2: rowBelow[col].hsbColor, t: 0.75)
        }
    }

    for (rowIndex, _) in matrix.enumerated() {
      for colIndex in 0..<cols {
        matrix[rowIndex][colIndex].position.y = helper.position(for: rowIndex, and: colIndex).y
      }
    }
  }
}
