//
//  VertexLocation.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation

enum VertexLocation {
  /// The axes of the edges.
  enum EdgeAxis {
    /// The vertical edge of the grid (i.e.: column).
    case vertical

    /// The horizontal edge of the grid (i.e.: row).
    case horizontal
  }

  /// The vertex is located in any of the corners of the grid.
  case corner

  /// The vertex is located in either the vertical or horizontal edges of the grid.
  case edge(axis: EdgeAxis)

  /// The vertex is located in the center area of the grid.
  case center
}
