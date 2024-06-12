//
//  MeshVertex.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/06/24.
//

import Foundation
import SwiftUI

/// An object that represents a vertex suitable for a mesh.
@Observable
class MeshVertex: Identifiable {

  // MARK: - Stored Properties

  /// The position of the vertex in the mesh, with components in the range `0...1`.
  var position: CGPoint

  /// The color of the vertex in `HSB` format.
  var hsbColor: HSB

  // MARK: - Computed Properties

  /// The vector representation of the vertex.
  var simd: SIMD2<Float> {
    [Float(position.x), Float(position.y)]
  }

  /// The `Color` representation of the color.
  var color: Color {
    hsbColor.color
  }

  var id: ObjectIdentifier {
    ObjectIdentifier(self)
  }

  // MARK: - Init

  init(x: CGFloat, y: CGFloat, color: HSB) {
    self.position = CGPoint(x: x, y: y)
    self.hsbColor = color
  }
}

extension MeshVertex: Equatable {
  static func ==(lhs: MeshVertex, rhs: MeshVertex) -> Bool {
    lhs.position == rhs.position && lhs.hsbColor == rhs.hsbColor
  }
}
