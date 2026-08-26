//
//  AnimatedCircleView.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct AnimatedCircleView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var isAnimatingGradient = false

    private let diameter: CGFloat

    init(diameter: CGFloat = 256) {
        self.diameter = diameter
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.customIndigoMedium, .customSalmonLight],
                        startPoint: isAnimatingGradient ? .topLeading : .bottomLeading,
                        endPoint: isAnimatingGradient ? .bottomTrailing : .topTrailing
                    )
                )

            MotionAnimationView(canvasSize: diameter)
        }
        .frame(width: diameter, height: diameter)
        .accessibilityHidden(true)
        .onAppear { updateAnimation() }
        .onChange(of: reduceMotion) { _, _ in updateAnimation() }
    }

    private func updateAnimation() {
        guard !reduceMotion else {
            withAnimation(.default) { isAnimatingGradient = false }
            return
        }
        withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
            isAnimatingGradient = true
        }
    }
}

#Preview {
    AnimatedCircleView()
}
