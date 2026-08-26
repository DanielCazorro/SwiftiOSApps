//
//  HikeIconButtonLabel.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct HikeIconButtonLabel: View {
    let systemImage: String

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    .hikeVertical([.white, .customGreenLight, .customGreenMedium])
                )

            Circle()
                .strokeBorder(.hikeTitle, lineWidth: 4)

            Image(systemName: systemImage)
                .font(.system(size: 26, weight: .black))
                .foregroundStyle(.hikeVertical([.customGreenLight, .customGrayMedium]))
                .contentTransition(.symbolEffect(.replace))
                .animation(.snappy, value: systemImage)
        }
        .frame(width: 58, height: 58)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HStack {
        HikeIconButtonLabel(systemImage: "figure.hiking")
        HikeIconButtonLabel(systemImage: "heart.fill")
    }
    .padding()
}
