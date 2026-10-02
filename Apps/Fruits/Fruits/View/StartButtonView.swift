//
//  StartButtonView.swift
//  Fruits
//
//  Created by Daniel Cazorro on 19/09/2026.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - Properties
    @AppStorage("isOnboarding") private var isOnboarding = true

    // MARK: - Body
    var body: some View {
        Button {
            isOnboarding = false
        } label: {
            HStack(spacing: 8) {
                Text("Start")

                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
        } // Button
        .accentColor(.white)
    }
}

#Preview {
    StartButtonView()
        .preferredColorScheme(.dark)
}
