//
//  MeshPreset.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

/// A type that represents a preset for a mesh.
struct MeshPreset: Identifiable {
  /// The identifiers for a preset.
  enum Identifier: Hashable, Equatable {
    /// The rainbow preset.
    case rainbow

    /// The aurora preset.
    case aurora

    /// The customizable mesh.
    case custom(columns: Int, rows: Int)
  }

  let id: Identifier

  /// The label describing the preset.
  let label: String

  /// The generator of the mesh.
  let generator: MeshGenerator
}

extension MeshPreset: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension MeshPreset {
  static func ==(lhs: MeshPreset, rhs: MeshPreset) -> Bool {
    lhs.id == rhs.id
  }
}

extension MeshPreset {
  /// A rainbow mesh.
  static var rainbow: MeshPreset {
    MeshPreset(id: .rainbow, label: "Rainbow", generator: .rainbow(columns: 5, rows: 5))
  }

  /// A aurora mesh.
  static var aurora: MeshPreset {
    MeshPreset(id: .aurora, label: "Aurora", generator: .aurora)
  }

  /// A custom mesh with default values.
  static var custom: MeshPreset {
    .custom(columns: 3, rows: 3)
  }

  /// Creates a custom mesh with the specified rows and columns.
  /// - Parameters:
  ///   - columns: The amount of columns in the mesh grid.
  ///   - rows: The amount of rows in the mesh grid.
  /// - Returns: A customizable mesh preset.
  static func custom(columns: Int, rows: Int) -> MeshPreset {
    MeshPreset(
      id: .custom(columns: columns, rows: rows),
      label: "Custom",
      generator: .custom(columns: columns, rows: rows)
    )
  }

  /// A list of the available presets.
  static var allCases: [MeshPreset] {
    [
      .rainbow,
      .aurora,
      .custom
    ]
  }
}
