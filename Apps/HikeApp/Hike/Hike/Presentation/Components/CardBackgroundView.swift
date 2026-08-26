//
//  CardBackgroundView.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import SwiftUI

struct CardBackgroundView: View {
    private let cornerRadius: CGFloat = 40
    private let shape: RoundedRectangle

    init() {
        shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        ZStack {
            // 3 — Depth: the darkest layer peeking out at the bottom.
            shape
                .fill(Color.customGreenDark)
                .offset(y: 12)

            // 2 — Light: a thin highlight between the depth and the surface.
            shape
                .fill(Color.customGreenLight)
                .opacity(0.85)
                .offset(y: 3)

            // 1 — Surface.
            shape
                .fill(.hikeVertical([.customGreenLight, .customGreenMedium]))
        }
        .accessibilityHidden(true)
    }
}

#Preview {
    CardBackgroundView()
        .frame(height: 320)
        .padding()
}
