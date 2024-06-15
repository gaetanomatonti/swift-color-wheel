//
//  AspectRatio.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 15/06/24.
//  Copyright © 2024 Gaetano Matonti. All rights reserved.
//

import Foundation

/// A type that represents the aspect ratio of a content.
struct AspectRatio {

  // MARK: - Stored Properties

  /// A label that describes the aspect ratio.
  let label: String

  /// The value of the aspect ratio.
  let value: CGFloat

  // MARK: - Init

  init(_ label: String, value: CGFloat) {
    self.label = label
    self.value = value
  }

  // MARK: - Functions

  /// Returns the value of the aspect ratio depending on the passed size.
  /// - Parameter size: The size of the content.
  func value(for size: CGSize) -> CGFloat {
    size.width > size.height ? value : 1 / value
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

  static let availableValues: [AspectRatio] = [
    .square,
    .sixteenByNine
  ]
}
