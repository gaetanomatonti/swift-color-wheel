//
//  GridHelper.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation

/// An object with helper functions for grid computations.
struct GridHelper {

  // MARK: - Stored Properties

  /// The columns of the grid.
  private let columns: Int

  /// The rows of the grid.
  private let rows: Int

  // MARK: - Init

  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows
  }

  // MARK: - Functions

  /// Computes the position of the point at the specified row and column in the range `[0, 1]`.
  /// - Parameters:
  ///   - row: The row of the point.
  ///   - column: The column of the point.
  /// - Returns: The `CGPoint` representing the position of the point in the grid.
  func position(for row: Int, and column: Int) -> CGPoint {
    CGPoint(
      x: CGFloat(column) / CGFloat(columns - 1),
      y: CGFloat(row) / CGFloat(rows - 1)
    )
  }

  /// Computes the index of a vertex in a flattened list of vertices.
  ///
  /// This method converts the row and columns indices from a matrix into an index suitable for a flattened list.
  ///
  /// - Parameters:
  ///   - row The row index of the vertex.
  ///   - column: The column index of the vertex.
  /// - Returns: The index for a flattened list.
  func index(for row: Int, and column: Int) -> Int {
    row * columns + column
  }

  /// Returns the location of the vertex in the grid.
  /// - Parameters:
  ///   - row The row index of the vertex.
  ///   - column: The column index of the vertex.
  /// - Returns: The `VertexLocation` of the vertex in the grid.
  func location(_ row: Int, _ column: Int) -> VertexLocation {
    if isCorner(row, column) {
      return .corner
    } else if isVerticalEdge(row, column) {
      return .edge(axis: .vertical)
    } else if isHorizontalEdge(row, column) {
      return .edge(axis: .horizontal)
    } else {
      return .center
    }
  }

  /// Checks whether the vertex at the specified row and column is a corner of the matrix.
  /// - Parameters:
  ///   - row The row index of the vertex.
  ///   - column: The column index of the vertex.
  /// - Returns: A `Bool` indicating whether the vertex is a corner of the matrix.
  private func isCorner(_ row: Int, _ column: Int) -> Bool {
    row == 0 && column == 0 || row == 0 && column == columns - 1 || row == rows - 1 && column == 0 || row == rows - 1 && column == columns - 1
  }

  /// Checks whether the vertex at the specified row and column is on either of the vertical edges of the matrix.
  /// - Parameters:
  ///   - row The row index of the vertex.
  ///   - column: The column index of the vertex.
  /// - Returns: A `Bool` indicating whether the vertex is on either of the vertical edges of the matrix.
  private func isVerticalEdge(_ row: Int, _ column: Int) -> Bool {
    column == 0 || column == columns - 1
  }

  /// Checks whether the vertex at the specified row and column is on either of the horizontal edges of the matrix.
  /// - Parameters:
  ///   - row The row index of the vertex.
  ///   - column: The column index of the vertex.
  /// - Returns: A `Bool` indicating whether the vertex is on either of the horizontal edges of the matrix.
  private func isHorizontalEdge(_ row: Int, _ column: Int) -> Bool {
    row == 0 || row == rows - 1
  }
}
