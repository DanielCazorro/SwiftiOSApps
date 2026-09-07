//
//  PageIndicatorView.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

struct PageIndicatorView: View {
    let count: Int
    let currentIndex: Int
    let onSelect: (Int) -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<count, id: \.self) { index in
                Button {
                    onSelect(index)
                } label: {
                    Circle()
                        .fill(.white.opacity(index == currentIndex ? 1 : 0.35))
                        .frame(width: 9, height: 9)
                        .scaleEffect(index == currentIndex ? 1.25 : 1)
                        .frame(width: 44, height: 44)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(Text("onboarding.page.position \(index + 1) \(count)"))
                .accessibilityAddTraits(index == currentIndex ? [.isButton, .isSelected] : .isButton)
            }
        }
        .animation(Motion.interactive(reduceMotion: reduceMotion), value: currentIndex)
        .frame(height: 44)
    }
}

#Preview {
    ZStack {
        Color.brandBlue.ignoresSafeArea()
        PageIndicatorView(count: 3, currentIndex: 1) { _ in }
    }
}
