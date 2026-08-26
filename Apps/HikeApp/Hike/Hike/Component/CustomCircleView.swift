//
//  CustomCircleView.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct CustomCircleView: View {
    @State private var isAnimateGradient = false


    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.customIndigoMedium, .customSalmonLight],
                        startPoint:  isAnimateGradient ? .topLeading : .bottomLeading,
                        endPoint: isAnimateGradient ? .bottomTrailing : .topTrailing
                    )
                )
                .onAppear {
                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                        isAnimateGradient.toggle()
                    }
                }

            MotionAnimationView()
        } // : ZStack
        .frame(width: 256, height: 256)
    }
}

#Preview {
    CustomCircleView()
}
