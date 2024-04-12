//
//  ColorWheel.metal
//  ColorWheel
//
//  Created by Gaetano Matonti on 07/03/24.
//

#include <metal_stdlib>
using namespace metal;

#define M_TWO_PI_H (M_PI_H * 2)

half3 mod(half3 x, half3 y) {
  return x - y * floor(x / y);
}

half3 hsb2rgb(half3 color) {
  half hue = color.x, saturation = color.y, brightness = color.z;

  half3 modulo = mod(hue * 6.0 + half3(0.0, 4.0, 2.0), 6.0);

  half3 rgb = clamp(abs(modulo - 3.0) - 1.0, 0.0, 1.0);

  rgb = rgb * rgb * (3.0 - 2.0 * rgb);
  return brightness * mix(half3(1.0), rgb, saturation);
}

[[ stitchable ]] half4 colorWheel(float2 position, float4 bounds, float brightness) {
  float2 st = position / bounds.zw;
  float2 center = st - float2(0.5);
  float angle = atan2(center.y, center.x);
  float radius = length(center) * 2.0;

  float hue = angle / M_TWO_PI_H;
  float saturation = radius;

  half3 rgb = hsb2rgb(half3(hue, saturation, brightness));

  return half4(rgb, 1.0);
}

[[ stitchable ]] half4 hue(float2 position, float4 bounds) {
  float hue = position.x / bounds.z;

  half3 rgb = hsb2rgb(half3(hue, 1, 1));

  return half4(rgb, 1.0);
}
