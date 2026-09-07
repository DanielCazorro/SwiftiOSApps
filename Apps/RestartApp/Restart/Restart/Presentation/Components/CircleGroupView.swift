//
//  CircleGroupView.swift
//  Restart
//
//  Created by Daniel Cazorro on 04/09/2026.
//

import SwiftUI

struct CircleGroupView: View {
    let color: Color
    let opacity: Double
    var diameter: CGFloat = Layout.circleDiameter

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(opacity), lineWidth: 40)
            Circle()
                .stroke(color.opacity(opacity), lineWidth: 80)
        }
        .frame(width: diameter, height: diameter)
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(Motion.entrance(reduceMotion: reduceMotion), value: isAnimating)
        .accessibilityHidden(true)
        .onAppear { isAnimating = true }
    }
}

#Preview {
    ZStack {
        Color.brandBlue.ignoresSafeArea()
        CircleGroupView(color: .white, opacity: 0.2)
    }
}
