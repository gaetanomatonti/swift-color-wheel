//
//  ColorWheel.metal
//  ColorWheel
//
//  Created by Gaetano Matonti on 07/03/24.
//

#include <metal_stdlib>
using namespace metal;

#define TWO_PI (M_PI_H * 2)

half3 mod(half3 x, half3 y) {
    return x - y * floor(x / y);
}

half3 hsb2rgb(half3 color) {
  half3 modulo = mod(color.x * 6.0 + half3(0.0, 4.0, 2.0), 6.0);

  half3 rgb = clamp(abs(modulo - 3.0) -1.0, 0.0, 1.0);

  rgb = rgb * rgb * (3.0 - 2.0 * rgb);
  return color.z * mix(half3(1.0), rgb, color.y);
}

[[ stitchable ]] half4 colorWheel(float2 position, float4 bounds) {
  float2 st = position / bounds.zw;
  float2 toCenter = float2(0.5) - st;
  float angle = atan2(toCenter.y, toCenter.x);
  float radius = length(toCenter) * 2.0;

  float hue = (angle / TWO_PI) + 0.5;
  float saturation = radius;
  float brightness = 1.0;

  half3 rgb = hsb2rgb(half3(hue, saturation, brightness));

  return half4(rgb, 1.0);
}
