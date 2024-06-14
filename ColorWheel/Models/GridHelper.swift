//
//  GridHelper.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 14/06/24.
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
}
