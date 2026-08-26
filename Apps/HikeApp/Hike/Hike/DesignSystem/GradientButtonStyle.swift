//
//  GradientButtonStyle.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background {
                let colors: [Color] = configuration.isPressed
                    ? [.customGrayMedium, .customGrayLight]
                    : [.customGrayLight, .customGrayMedium]

                Capsule().fill(.hikeVertical(colors))
            }
            .contentShape(.capsule)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == GradientButtonStyle {
    static var gradient: GradientButtonStyle { GradientButtonStyle() }
}

#Preview(traits: .sizeThatFitsLayout) {
    Button("Explore More") {}
        .font(.title2.weight(.heavy))
        .foregroundStyle(.hikeAccent)
        .buttonStyle(.gradient)
        .padding()
}
