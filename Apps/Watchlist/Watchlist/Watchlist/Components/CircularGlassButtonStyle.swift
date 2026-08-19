//
//  CircularGlassButtonStyle.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 19/08/2026.
//

import SwiftUI

/// Round, glass-backed action button used by the floating bar.
///
/// The size follows Dynamic Type via `@ScaledMetric` instead of a hardcoded
/// frame, so the control keeps its 44pt minimum target at every text size.
struct CircularGlassButtonStyle: ButtonStyle {
    var isProminent: Bool = false
    @ScaledMetric(relativeTo: .title) private var diameter: CGFloat = 56

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2.weight(.semibold))
            .foregroundStyle(isProminent ? AnyShapeStyle(.white) : AnyShapeStyle(Theme.brand))
            .frame(width: diameter, height: diameter)
            .background {
                if isProminent {
                    Circle().fill(Theme.brand)
                } else {
                    Circle().fill(.regularMaterial)
                }
            }
            .overlay(Circle().strokeBorder(.white.opacity(isProminent ? 0.25 : 0.12), lineWidth: 1))
            .shadow(color: .black.opacity(0.18), radius: configuration.isPressed ? 4 : 10, y: 4)
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .animation(.snappy(duration: 0.2), value: configuration.isPressed)
            .contentShape(.circle)
    }
}

extension ButtonStyle where Self == CircularGlassButtonStyle {
    static var circularGlass: Self { CircularGlassButtonStyle() }
    static var circularProminent: Self { CircularGlassButtonStyle(isProminent: true) }
}

#Preview {
    HStack(spacing: Theme.Spacing.large) {
        Button { } label: { Image(systemName: "shuffle") }
            .buttonStyle(.circularGlass)
        Button { } label: { Image(systemName: "plus") }
            .buttonStyle(.circularProminent)
    }
    .padding()
    .background(.background.secondary)
}
