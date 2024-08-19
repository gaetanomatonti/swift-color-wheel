//
//  ColorSlider+Track.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 13/04/24.
//

import Foundation
import SwiftUI

extension ColorSlider {
  /// A view that displays the track of the slider.
  struct Track: View {

    // MARK: - Computed Properties

    @Environment(\.colorSliderTrackStyle) var style

    // MARK: - Body

    var body: some View {
      GeometryReader { geometry in
        let frame = geometry.frame(in: .local)
        
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .fill(style)
          .stroke(.thinMaterial, lineWidth: 2)
          .frame(width: frame.width)
      }
    }
  }
}
