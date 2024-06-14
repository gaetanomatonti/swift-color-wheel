//
//  LinearInterpolation.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 14/06/24.
//

import Foundation

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
