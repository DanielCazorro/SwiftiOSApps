//
//  ZoomControlsView.swift
//  Pinch
//
//  Created by Daniel Cazorro on 09/09/2026.
//

import SwiftUI

struct ZoomControlsView: View {
    let canZoomOut: Bool
    let canZoomIn: Bool
    let isZoomedIn: Bool
    let zoomPercentage: Int
    let onZoomOut: () -> Void
    let onReset: () -> Void
    let onZoomIn: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            Button(action: onZoomOut) {
                ControlIconLabel(icon: "minus.magnifyingglass")
            }
            .disabled(!canZoomOut)
            .accessibilityLabel("viewer.zoom.out")

            Button(action: onReset) {
                ControlIconLabel(icon: "arrow.up.left.and.down.right.magnifyingglass")
            }
            .disabled(!isZoomedIn)
            .accessibilityLabel("viewer.zoom.reset")
            .accessibilityValue(Text(ViewerStrings.zoomPercentage(zoomPercentage)))

            Button(action: onZoomIn) {
                ControlIconLabel(icon: "plus.magnifyingglass")
            }
            .disabled(!canZoomIn)
            .accessibilityLabel("viewer.zoom.in")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Layout.panelCornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Layout.panelCornerRadius)
                .strokeBorder(.white.opacity(0.12))
        )
        .shadow(color: .black.opacity(0.15), radius: 10, y: 4)
    }
}

#Preview {
    ZoomControlsView(
        canZoomOut: false,
        canZoomIn: true,
        isZoomedIn: false,
        zoomPercentage: 100,
        onZoomOut: {},
        onReset: {},
        onZoomIn: {}
    )
    .padding()
    .preferredColorScheme(.dark)
}
