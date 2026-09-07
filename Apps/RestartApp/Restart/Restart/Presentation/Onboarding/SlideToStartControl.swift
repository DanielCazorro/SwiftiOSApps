//
//  SlideToStartControl.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import SwiftUI

struct SlideToStartControl: View {
    let offset: CGFloat
    let onDragChanged: (_ translation: CGFloat, _ trackWidth: CGFloat) -> Void
    let onDragEnded: (_ trackWidth: CGFloat) -> Void
    let onActivate: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let knobSize = Layout.knobSize

    var body: some View {
        GeometryReader { proxy in
            let trackWidth = proxy.size.width

            ZStack(alignment: .leading) {
                Capsule().fill(.white.opacity(0.2))
                Capsule().fill(.white.opacity(0.2)).padding(8)

                Text("onboarding.cta.getStarted")
                    .font(.system(.title3, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, knobSize / 2)
                    .padding(.trailing, 8)
                    .opacity(1 - progress(in: trackWidth))

                Capsule()
                    .fill(Color.brandRed)
                    .frame(width: offset + knobSize)

                knob
                    .offset(x: offset)
                    .gesture(dragGesture(trackWidth: trackWidth))
            }
        }
        .frame(height: knobSize)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("onboarding.cta.getStarted")
        .accessibilityHint("onboarding.cta.hint")
        .accessibilityAddTraits(.isButton)
        .accessibilityAction(.default, onActivate)
    }

    private var knob: some View {
        ZStack {
            Circle().fill(Color.brandRed)
            Circle().fill(.black.opacity(0.12)).padding()
            Image(systemName: "chevron.right.2")
                .font(.system(size: 24, weight: .bold))
        }
        .foregroundStyle(.white)
        .frame(width: knobSize, height: knobSize)
    }

    private func dragGesture(trackWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                onDragChanged(gesture.translation.width, trackWidth)
            }
            .onEnded { _ in
                withAnimation(Motion.interactive(reduceMotion: reduceMotion)) {
                    onDragEnded(trackWidth)
                }
            }
    }

    private func progress(in trackWidth: CGFloat) -> Double {
        let travel = max(trackWidth - knobSize, 1)
        return min(max(offset / travel, 0), 1)
    }
}

#Preview {
    ZStack {
        Color.brandBlue.ignoresSafeArea()
        SlideToStartControl(offset: 0, onDragChanged: { _, _ in }, onDragEnded: { _ in }, onActivate: {})
            .padding(.horizontal, Layout.horizontalPadding)
    }
}
