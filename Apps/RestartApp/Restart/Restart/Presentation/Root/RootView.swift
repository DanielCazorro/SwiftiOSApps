//
//  RootView.swift
//  Restart
//
//  Created by Daniel Cazorro on 01/09/2026.
//

import SwiftUI

struct RootView: View {
    let dependencies: AppDependencies

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var settings: AppSettings { dependencies.settings }

    var body: some View {
        ZStack {
            if settings.hasCompletedOnboarding {
                HomeView(
                    viewModel: HomeViewModel(
                        quoteRepository: dependencies.quotes,
                        feedback: dependencies.feedback,
                        settings: settings
                    )
                )
                .transition(.opacity)
            } else {
                OnboardingView(
                    viewModel: OnboardingViewModel(
                        content: dependencies.onboardingContent,
                        feedback: dependencies.feedback,
                        settings: settings
                    )
                )
                .transition(.opacity)
            }
        }
        .animation(Motion.entrance(reduceMotion: reduceMotion), value: settings.hasCompletedOnboarding)
        .task { dependencies.feedback.prepare() }
    }
}

#Preview("Onboarding") {
    RootView(dependencies: AppDependencies.preview)
}

#Preview("Home") {
    RootView(dependencies: AppDependencies(preferences: InMemoryPreferencesRepository(hasCompletedOnboarding: true)))
}
