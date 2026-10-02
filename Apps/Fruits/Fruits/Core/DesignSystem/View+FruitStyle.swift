//
//  View+FruitStyle.swift
//  Fruits
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import SwiftUI

extension View {
    func fruitImageShadow() -> some View {
        shadow(color: .black.opacity(0.15), radius: 8, x: 6, y: 8)
    }

    func scaleInOnAppear() -> some View {
        modifier(ScaleInOnAppear())
    }
}

private struct ScaleInOnAppear: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isVisible = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isVisible || reduceMotion ? 1 : 0.6)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    isVisible = true
                }
            }
    }
}
