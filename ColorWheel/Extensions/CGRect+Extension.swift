//
//  CGRect+Extension.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 08/03/24.
//

import Foundation

extension CGRect {
  /// Returns the center of the rectangle.
  var center: CGPoint {
    CGPoint(x: midX, y: midY)
  }
}
