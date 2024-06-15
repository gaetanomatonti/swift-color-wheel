//
//  MeshConfigurationView.swift
//  ColorWheel
//
//  Created by Gaetano Matonti on 12/06/24.
//

import SwiftUI

/// A view to configure a mesh gradient.
struct MeshConfigurationView: View {

  // MARK: - Stored Properties

  @Environment(\.dismiss) var dismiss

  /// The number of columns in the mesh.
  @Binding var columns: Int

  /// The number of rows in the mesh.
  @Binding var rows: Int

  @Binding var areCornersLocked: Bool

  @Binding var areEdgesLocked: Bool

  /// The range of allowed columns and rows in the grid.
  private let pointsRange = 2...6

  // MARK: - Body

  var body: some View {
    Form {
      #if os(macOS)
      VStack(alignment: .center) {
        columnsStepper
        
        rowsStepper

        cornersLock

        edgesLock

        Button {
          dismiss()
        } label: {
          Text("Done")
        }
      }
      .scenePadding()
      #else
      columnsStepper

      rowsStepper

      cornersLock

      edgesLock
      #endif
    }
  }

  // MARK: - Subviews

  private var columnsStepper: some View {
    Stepper(value: $columns, in: pointsRange) {
      HStack {
        Text("Columns")
        Spacer()
        Text("\(columns)")
      }
    }
  }

  private var rowsStepper: some View {
    Stepper(value: $rows, in: pointsRange) {
      HStack {
        Text("Rows")
        Spacer()
        Text("\(rows)")
      }
    }
  }

  private var cornersLock: some View {
    Toggle("Lock corners", isOn: $areCornersLocked)
  }

  private var edgesLock: some View {
    Toggle("Lock edges", isOn: $areEdgesLocked)
  }
}

