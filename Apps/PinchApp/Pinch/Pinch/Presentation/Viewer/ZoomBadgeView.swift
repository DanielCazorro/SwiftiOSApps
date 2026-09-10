//
//  ZoomBadgeView.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import SwiftUI

struct ZoomBadgeView: View {
    let percentage: Int

    var body: some View {
        Text(ViewerStrings.zoomPercentage(percentage))
            .font(.footnote.weight(.semibold))
            .monospacedDigit()
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial, in: .capsule)
            .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
            .accessibilityHidden(true)
    }
}

#Preview {
    ZoomBadgeView(percentage: 320)
        .padding()
        .preferredColorScheme(.dark)
}
