//
//  OnboardingStoreTests.swift
//  FruitsTests
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Foundation
import Testing
@testable import Fruits

struct OnboardingStoreTests {
    private let defaults: UserDefaults

    init() throws {
        let suiteName = "OnboardingStoreTests.\(UUID().uuidString)"
        defaults = try #require(UserDefaults(suiteName: suiteName))
        defaults.removePersistentDomain(forName: suiteName)
    }

    @Test func showsOnboardingOnFirstLaunch() {
        #expect(OnboardingStore(defaults: defaults).isOnboarding)
    }

    @Test func completingOnboardingIsPersisted() {
        OnboardingStore(defaults: defaults).complete()

        #expect(OnboardingStore(defaults: defaults).isOnboarding == false)
    }

    @Test func restartingAfterCompletionShowsOnboardingAgain() {
        let store = OnboardingStore(defaults: defaults)
        store.complete()

        store.restart()

        #expect(store.isOnboarding)
        #expect(OnboardingStore(defaults: defaults).isOnboarding)
    }
}
