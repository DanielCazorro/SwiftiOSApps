//
//  MotionAnimationView.swift
//  Hike
//
//  Created by Daniel Cazorro on 22/08/2026.
//

import SwiftUI

struct MotionAnimationView: View {
    // MARK: - Properties
    @State private var randomCircle: Int = .random(in: 6...12)
    @State private var isAnimating = false

    // MARK: - Functions
    //1. Random Coordiante
    func randomCoordiante() -> CGFloat {
        CGFloat.random(in: 0...256)
    }

    //2. Random Size
    func randomSize() -> CGFloat {
        CGFloat(Int.random(in: 4...80))
    }

    //3. Random Scale
    func randomScale() -> CGFloat {
        CGFloat(Double.random(in: 0.1...2.0))
    }

    //4. Random Speed
    func randomSpeed() -> Double {
        Double.random(in: 0.05...1.0)
    }

    //5. Random Delay

    var body: some View {
        ZStack {
            ForEach(0...randomCircle, id: \.self) { item in
                Circle()
                    .foregroundColor(.white)
                    .opacity(0.25)
                    .frame(width: randomSize())
                    .position(x: randomCoordiante(), y: randomCoordiante())
                    .scaleEffect(isAnimating ? randomScale() : 1)
                    .onAppear(perform: {
                        withAnimation(
                            .interpolatingSpring(stiffness: 0.25, damping: 0.25)
                                .repeatForever()
                                .speed(randomSpeed())
                        ) {
                            isAnimating = true
                        }
                    })
            }
        } // : ZStack
        .frame(width: 256, height: 256)
    }
}

#Preview {
    ZStack {
        Color.teal.ignoresSafeArea()

        MotionAnimationView()
    }
}
