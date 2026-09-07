//
//  TestDoubles.swift
//  RestartTests
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
@testable import Restart

/// Records what the screens asked for, so the tests can assert on feedback without any audio
/// or haptic hardware.
@MainActor
final class SpyFeedbackPlayer: FeedbackPlaying {
    private(set) var playedSounds: [SoundEffect] = []
    private(set) var vibrations: [HapticFeedback] = []
    private(set) var prepareCallCount = 0

    func play(_ sound: SoundEffect) { playedSounds.append(sound) }
    func vibrate(_ feedback: HapticFeedback) { vibrations.append(feedback) }
    func prepare() { prepareCallCount += 1 }
}

struct StubOnboardingContentRepository: OnboardingContentRepository {
    var slides: [OnboardingSlide]

    init(count: Int = 3) {
        slides = (0..<count).map { index in
            OnboardingSlide(
                id: index,
                titleKey: "slide.\(index).title",
                messageKey: "slide.\(index).message",
                imageName: "character-1",
                imageAccessibilityKey: "slide.\(index).image"
            )
        }
    }

    func allSlides() -> [OnboardingSlide] { slides }
}

struct StubQuoteRepository: QuoteRepository {
    var quotes: [Quote]

    init(count: Int = 4) {
        quotes = (1...max(count, 1)).map { index in
            Quote(id: "quote.\(index)", textKey: "quote.\(index).text", authorKey: "quote.\(index).author")
        }
    }

    func allQuotes() -> [Quote] { quotes }
}

@MainActor
enum TestEnvironment {
    /// A fully wired graph on in-memory storage.
    static func make(
        hasCompletedOnboarding: Bool = false,
        isSoundEnabled: Bool = true,
        slideCount: Int = 3,
        quoteCount: Int = 4
    ) -> (settings: AppSettings, feedback: SpyFeedbackPlayer, onboarding: OnboardingViewModel, home: HomeViewModel) {
        let preferences = InMemoryPreferencesRepository(
            hasCompletedOnboarding: hasCompletedOnboarding,
            isSoundEnabled: isSoundEnabled
        )
        let settings = AppSettings(preferences: preferences)
        let feedback = SpyFeedbackPlayer()
        let onboarding = OnboardingViewModel(
            content: StubOnboardingContentRepository(count: slideCount),
            feedback: feedback,
            settings: settings
        )
        let home = HomeViewModel(
            quoteRepository: StubQuoteRepository(count: quoteCount),
            feedback: feedback,
            settings: settings
        )
        return (settings, feedback, onboarding, home)
    }
}
