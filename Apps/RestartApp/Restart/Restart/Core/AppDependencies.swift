//
//  AppDependencies.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

@MainActor
struct AppDependencies {
    let settings: AppSettings
    let feedback: FeedbackPlaying
    let onboardingContent: OnboardingContentRepository
    let quotes: QuoteRepository

    init(preferences: PreferencesRepository = UserDefaultsPreferencesRepository()) {
        self.settings = AppSettings(preferences: preferences)
        self.feedback = SystemFeedbackPlayer(preferences: preferences)
        self.onboardingContent = BundledOnboardingContentRepository()
        self.quotes = BundledQuoteRepository()
    }

    init(
        settings: AppSettings,
        feedback: FeedbackPlaying,
        onboardingContent: OnboardingContentRepository,
        quotes: QuoteRepository
    ) {
        self.settings = settings
        self.feedback = feedback
        self.onboardingContent = onboardingContent
        self.quotes = quotes
    }
}

extension AppDependencies {
    static var preview: AppDependencies {
        AppDependencies(preferences: InMemoryPreferencesRepository())
    }
}

final class InMemoryPreferencesRepository: PreferencesRepository {
    var hasCompletedOnboarding: Bool
    var isSoundEnabled: Bool

    init(hasCompletedOnboarding: Bool = false, isSoundEnabled: Bool = true) {
        self.hasCompletedOnboarding = hasCompletedOnboarding
        self.isSoundEnabled = isSoundEnabled
    }
}
