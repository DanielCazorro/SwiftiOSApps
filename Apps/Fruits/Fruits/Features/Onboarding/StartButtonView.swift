//
//  StartButtonView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 19/09/2026.
//

import SwiftUI

struct StartButtonView: View {
    @Environment(OnboardingStore.self) private var onboardingStore

    var body: some View {
        Button {
            onboardingStore.complete()
        } label: {
            HStack(spacing: 8) {
                Text("Start")

                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Capsule().strokeBorder(.white, lineWidth: 1.25))
        }
        .tint(.white)
    }
}

#Preview {
    StartButtonView()
        .padding()
        .background(.black)
        .environment(OnboardingStore())
}
