//
//  AspectRatio.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//

import Foundation

/// A type that represents the aspect ratio of a content.
struct AspectRatio {
  /// A label that describes the aspect ratio.
  let label: String

  /// The value of the aspect ratio.
  let value: CGFloat

  init(_ label: String, value: CGFloat) {
    self.label = label
    self.value = value
  }
}

extension AspectRatio: Hashable {}

extension AspectRatio: Identifiable {
  var id: CGFloat {
    value
  }
}

extension AspectRatio {
  static let square = AspectRatio("Square", value: 1.0)

  static let sixteenByNine = AspectRatio("16:9", value: 16.0 / 9.0)

  static let values: [AspectRatio] = [
    .square,
    .sixteenByNine
  ]
}
