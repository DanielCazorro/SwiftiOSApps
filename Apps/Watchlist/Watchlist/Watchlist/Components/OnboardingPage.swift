//
//  OnboardingPage.swift
//  Watchlist
//
//  Created by Daniel Cazorro on 18/08/2026.
//

import SwiftUI

/// One page of the empty-state carousel.
struct OnboardingPage: View {
    let symbolName: String
    let message: LocalizedStringResource

    var body: some View {
        VStack(spacing: Theme.Spacing.medium) {
            Image(systemName: symbolName)
                .font(.largeTitle)
                .foregroundStyle(Theme.brand)
                .symbolEffect(.breathe)
                .accessibilityHidden(true)

            Text(message)
                .font(.headline)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, Theme.Spacing.large)
        // Leaves room for the page indicator underneath.
        .padding(.bottom, Theme.Spacing.extraLarge)
    }
}

#Preview {
    OnboardingPage(symbolName: "plus.circle", message: "onboarding.add.message")
        .padding()
}
