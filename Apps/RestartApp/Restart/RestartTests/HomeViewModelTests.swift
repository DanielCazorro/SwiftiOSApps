//
//  HomeViewModelTests.swift
//  RestartTests
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Testing
@testable import Restart

@MainActor
@Suite("Home")
struct HomeViewModelTests {
    @Test("A new quote is never the one already on screen")
    func anotherQuoteIsAlwaysDifferent() {
        let env = TestEnvironment.make(quoteCount: 4)

        for _ in 0..<50 {
            let previous = env.home.currentQuote
            env.home.showAnotherQuote()
            #expect(env.home.currentQuote != previous)
        }
    }

    @Test("With a single quote there is nothing to shuffle")
    func singleQuoteKeepsItsPlace() {
        let env = TestEnvironment.make(quoteCount: 1)
        let quote = env.home.currentQuote

        #expect(env.home.canShowAnotherQuote == false)
        env.home.showAnotherQuote()

        #expect(env.home.currentQuote == quote)
        #expect(env.feedback.vibrations.isEmpty)
    }

    @Test("Restart sends the user back to the welcome flow")
    func restartClearsTheOnboardingFlag() {
        let env = TestEnvironment.make(hasCompletedOnboarding: true)

        env.home.restart()

        #expect(env.settings.hasCompletedOnboarding == false)
        #expect(env.feedback.playedSounds == [.restart])
        #expect(env.feedback.vibrations == [.success])
    }

    @Test("The sound toggle writes through to the settings")
    func soundToggleUpdatesSettings() {
        let env = TestEnvironment.make(isSoundEnabled: true)

        env.home.toggleSound()
        #expect(env.home.isSoundEnabled == false)
        #expect(env.settings.isSoundEnabled == false)

        env.home.toggleSound()
        #expect(env.settings.isSoundEnabled)
    }
}
