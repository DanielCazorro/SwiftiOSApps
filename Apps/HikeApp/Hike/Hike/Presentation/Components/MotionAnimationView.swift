//
//  MotionAnimationView.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct MotionAnimationView: View {
    private struct Bubble: Identifiable {
        let id = UUID()
        let position: CGPoint
        let diameter: CGFloat
        let scale: CGFloat
        let speed: Double
        let delay: Double
    }

    // MARK: - Properties

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var bubbles: [Bubble]
    @State private var isAnimating = false

    private let canvasSize: CGFloat

    // MARK: - Init

    init(canvasSize: CGFloat = 256) {
        self.canvasSize = canvasSize
        _bubbles = State(initialValue: Self.makeBubbles(canvasSize: canvasSize))
    }

    private static func makeBubbles(canvasSize: CGFloat) -> [Bubble] {
        (0..<Int.random(in: 6...12)).map { _ in
            Bubble(
                position: CGPoint(
                    x: .random(in: 0...canvasSize),
                    y: .random(in: 0...canvasSize)
                ),
                diameter: .random(in: 4...80),
                scale: .random(in: 0.1...2.0),
                speed: .random(in: 0.05...1.0),
                delay: .random(in: 0...2)
            )
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            ForEach(bubbles) { bubble in
                Circle()
                    .fill(.white.opacity(0.25))
                    .frame(width: bubble.diameter, height: bubble.diameter)
                    .scaleEffect(isAnimating ? bubble.scale : 1)
                    .position(bubble.position)
                    .animation(animation(for: bubble), value: isAnimating)
            }
        }
        .frame(width: canvasSize, height: canvasSize)
        .accessibilityHidden(true)
        .onAppear {
            guard !reduceMotion else { return }
            isAnimating = true
        }
        .onChange(of: reduceMotion) { _, isReduced in
            isAnimating = !isReduced
        }
    }

    private func animation(for bubble: Bubble) -> Animation? {
        guard !reduceMotion else { return nil }
        return .interpolatingSpring(stiffness: 0.25, damping: 0.25)
            .repeatForever()
            .speed(bubble.speed)
            .delay(bubble.delay)
    }
}

#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()
        MotionAnimationView()
    }
}
