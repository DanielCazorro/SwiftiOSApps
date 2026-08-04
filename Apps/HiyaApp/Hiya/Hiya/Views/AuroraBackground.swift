//
//  AuroraBackground.swift
//  Hiya
//
//  Created by Daniel Cazorro on 04/08/2026.
//

import SwiftUI
import UIKit

/// Fondo de manchas de color desenfocadas que respiran despacio.
/// Se acelera un poco mientras la IA está escribiendo.
struct AuroraBackground: View {
    var isActive: Bool = false

    @State private var drift: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            Color(.systemBackground)

            blob(.purple, opacity: 0.45, size: 340, x: -110, y: -260 + drift)
            blob(.blue, opacity: 0.35, size: 320, x: 140, y: -80 - drift)
            blob(.pink, opacity: 0.30, size: 300, x: -70, y: 280 + drift)
        }
        .ignoresSafeArea()
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: isActive ? 2.5 : 6).repeatForever(autoreverses: true)) {
                drift = 45
            }
        }
    }

    private func blob(_ color: Color, opacity: Double, size: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        Circle()
            .fill(color.opacity(opacity))
            .frame(width: size, height: size)
            .blur(radius: 90)
            .offset(x: x, y: y)
    }
}

// MARK: - Previews

#Preview("Claro") {
    AuroraBackground()
}

#Preview("Oscuro") {
    AuroraBackground()
        .preferredColorScheme(.dark)
}
