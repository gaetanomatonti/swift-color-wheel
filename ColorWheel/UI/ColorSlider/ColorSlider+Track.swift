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

    // MARK: - Stored Properties

    /// The frame of the view.
    let frame: CGRect

    // MARK: - Computed Properties

    @Environment(\.colorSliderTrackStyle) var style

    // MARK: - Body

    var body: some View {
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(style)
        .stroke(.thinMaterial, lineWidth: 2)
        .frame(width: frame.width)
    }
  }
}
