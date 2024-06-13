//
//  MeshGenerator.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 13/06/24.
//

import Foundation
import Vectors

struct MeshGenerator {
  let columns: Int

  let rows: Int

  func generateVertices() -> [[MeshVertex]] {
    guard columns > 1 && rows > 1 else {
      return [[]]
    }

    var vertices: [[MeshVertex]] = Array(repeating: [], count: rows)

    for row in 0..<rows {
      for column in 0..<columns {
        let x = CGFloat(column) / CGFloat(columns - 1)
        let y = CGFloat(row) / CGFloat(rows - 1)
        let center = CGPoint(x: 0.5, y: 0.5)
        let position = CGPoint(x: x, y: y) - center

        let hue = atan2(position.y, position.x)
        let saturation = position.normalized.magnitude

        let color = HSB(hue: .radians(hue), saturation: saturation, brightness: 1)
        let vertex = MeshVertex(x: x, y: y, color: color)

        vertices[row].insert(vertex, at: column)
      }
    }

    return vertices
  }
}

@Observable
class MeshGrid {
  var columns: Int

  var rows: Int

  var matrix: [[MeshVertex]]

  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows
    self.matrix = MeshGenerator(columns: columns, rows: rows).generateVertices()
  }

  func addColumn() {
    addColumn(at: columns / 2)
  }

  func addColumn(at columnIndex: Int) {
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
    for row in 0..<rows {
      let c1 = matrix[row][columnIndex - 1]
      let c2 = matrix[row][columnIndex]
      let c3 = matrix[row][columnIndex - 1]
      let c4 = matrix[row][columnIndex]

      let vertex = blerp(c1: c1, c2: c2, c3: c3, c4: c4, tx: 0.5, ty: 0.5)
      matrix[row].insert(vertex, at: columnIndex)

      for column in 0..<columns {
        let x = CGFloat(column) / CGFloat(columns - 1)
        matrix[row][column].position.x = x
      }
    }
  }

  func removeColumn() {
    removeColumn(at: columns / 2)
  }

  func removeColumn(at columnIndex: Int) {
    guard columns > 1 else {
      return
    }

    guard columnIndex >= 0 && columnIndex < columns else {
      return
    }

    let rows = matrix.count

    // Remove the specified row
    for row in 0..<rows {
      matrix[row].remove(at: columnIndex)

      for column in 0..<columns {
        let x = CGFloat(column) / CGFloat(columns - 1)
        matrix[row][column].position.x = x

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
    let totalRows = matrix.count
    for (rowIndex, row) in matrix.enumerated() {
        let newY = CGFloat(rowIndex) / CGFloat(totalRows - 1)
        for colIndex in 0..<cols {
            matrix[rowIndex][colIndex].position.y = newY
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

    // Recalculate positions for all rows to be evenly spaced
    let totalRows = matrix.count
    for (rowIndex, _) in matrix.enumerated() {
      let newY = CGFloat(rowIndex) / CGFloat(totalRows - 1)
      for colIndex in 0..<cols {
        matrix[rowIndex][colIndex].position.y = newY
      }
    }
  }
}

func lerp<Value: BinaryFloatingPoint>(v1: Value, v2: Value, t: Value) -> Value {
    return v1 * (1 - t) + v2 * t
}

func lerp(v1: HSB, v2: HSB, t: CGFloat) -> HSB {
  let hue = lerp(v1: v1.hue.degrees, v2: v2.hue.degrees, t: t)
  let saturation = lerp(v1: v1.saturation, v2: v2.saturation, t: t)
  let brightness = lerp(v1: v1.brightness, v2: v2.brightness, t: t)
  return HSB(hue: .degrees(hue), saturation: saturation, brightness: brightness)
}

func blerp<Value: BinaryFloatingPoint>(c1: Value, c2: Value, c3: Value, c4: Value, tx: Value, ty: Value) -> Value {
  let v1 = c1 * (1.0 - tx) * (1.0 - ty)
  let v2 = c2 * tx * (1 - ty)
  let v3 = c3 * (1.0 - tx) * ty
  let v4 = c4 * tx * ty
  return v1 + v2 + v3 + v4
}

func blerp(c1: HSB, c2: HSB, c3: HSB, c4: HSB, tx: CGFloat, ty: CGFloat) -> HSB {
  let hue = blerp(c1: c1.hue.degrees, c2: c2.hue.degrees, c3: c3.hue.degrees, c4: c4.hue.degrees, tx: tx, ty: ty)
  let saturation = blerp(c1: c1.saturation, c2: c2.saturation, c3: c3.saturation, c4: c4.saturation, tx: tx, ty: ty)
  let brightness = blerp(c1: c1.brightness, c2: c2.brightness, c3: c3.brightness, c4: c4.brightness, tx: tx, ty: ty)
  return HSB(hue: .degrees(hue), saturation: saturation, brightness: brightness)
}

func blerp(c1: CGPoint, c2: CGPoint, c3: CGPoint, c4: CGPoint, tx: CGFloat, ty: CGFloat) -> CGPoint {
  let x = blerp(c1: c1.x, c2: c2.x, c3: c3.x, c4: c4.x, tx: tx, ty: ty)
  let y = blerp(c1: c1.y, c2: c2.y, c3: c3.y, c4: c4.y, tx: tx, ty: ty)
  return CGPoint(x: x, y: y)
}

func blerp(c1: MeshVertex, c2: MeshVertex, c3: MeshVertex, c4: MeshVertex, tx: CGFloat, ty: CGFloat) -> MeshVertex {
  let color = blerp(c1: c1.hsbColor, c2: c2.hsbColor, c3: c3.hsbColor, c4: c4.hsbColor, tx: tx, ty: ty)
  let position = blerp(c1: c1.position, c2: c2.position, c3: c3.position, c4: c4.position, tx: tx, ty: ty)
  return MeshVertex(position: position, color: color)
}
