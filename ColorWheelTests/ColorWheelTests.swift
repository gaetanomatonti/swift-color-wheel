//
//  ColorWheelTests.swift
//  ColorWheelTests
//
//  Created by Gaetano Matonti on 13/06/24.
//

import Testing
@testable import ColorWheel

struct ColorWheelTests {
  @Test
  func generateTwoByTwoMesh() {
    let generator = MeshGenerator(columns: 2, rows: 2)
    let vertices = generator.generateVertices()
    let expectedResult: [[MeshVertex]] = [
      [MeshVertex(x: 0.0, y: 0.0, color: .white), MeshVertex(x: 1.0, y: 0.0, color: .white)],
      [MeshVertex(x: 0.0, y: 1.0, color: .white), MeshVertex(x: 1.0, y: 1.0, color: .white)],
    ]
    withKnownIssue("Color depends on coordinates") {
      #expect(vertices == expectedResult)
    }
  }

  @Test
  func generateThreeByThreeMesh() {
    let generator = MeshGenerator(columns: 3, rows: 3)
    let vertices = generator.generateVertices()
    let expectedResult: [[MeshVertex]] = [
      [MeshVertex(x: 0.0, y: 0.0, color: .white), MeshVertex(x: 0.5, y: 0.0, color: .white), MeshVertex(x: 1.0, y: 0.0, color: .white)],
      [MeshVertex(x: 0.0, y: 0.5, color: .white), MeshVertex(x: 0.5, y: 0.5, color: .white), MeshVertex(x: 1.0, y: 0.5, color: .white)],
      [MeshVertex(x: 0.0, y: 1.0, color: .white), MeshVertex(x: 0.5, y: 1.0, color: .white), MeshVertex(x: 1.0, y: 1.0, color: .white)],
    ]
    withKnownIssue("Color depends on coordinates") {
      #expect(vertices == expectedResult)
    }
  }

  @Test
  func generateThreeByTwoMesh() {
    let generator = MeshGenerator(columns: 3, rows: 2)
    let vertices = generator.generateVertices()
    let expectedResult: [[MeshVertex]] = [
      [MeshVertex(x: 0.0, y: 0.0, color: .white), MeshVertex(x: 0.5, y: 0.0, color: .white), MeshVertex(x: 1.0, y: 0.0, color: .white)],
      [MeshVertex(x: 0.0, y: 1.0, color: .white), MeshVertex(x: 0.5, y: 1.0, color: .white), MeshVertex(x: 1.0, y: 1.0, color: .white)],
    ]
    withKnownIssue("Color depends on coordinates") {
      #expect(vertices == expectedResult)
    }
  }
}
