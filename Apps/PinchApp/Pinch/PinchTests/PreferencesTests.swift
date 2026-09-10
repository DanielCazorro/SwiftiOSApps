//
//  PreferencesTests.swift
//  PinchTests
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import Foundation
import Testing
@testable import Pinch

@Suite("Preferences")
struct PreferencesTests {
    private func makeRepository() throws -> (UserDefaultsPreferencesRepository, UserDefaults) {
        let name = "PinchTests.\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: name))
        return (UserDefaultsPreferencesRepository(defaults: defaults), defaults)
    }

    @Test("A fresh install has haptics on, no stored page and no guide seen")
    func defaults() throws {
        let (preferences, _) = try makeRepository()

        #expect(preferences.isHapticsEnabled)
        #expect(preferences.lastPageID == nil)
        #expect(preferences.hasSeenGuide == false)
    }

    @Test("Choices survive being written and read back")
    func roundTrip() throws {
        let (preferences, defaults) = try makeRepository()

        preferences.lastPageID = 4
        preferences.isHapticsEnabled = false
        preferences.hasSeenGuide = true

        let reopened = UserDefaultsPreferencesRepository(defaults: defaults)
        #expect(reopened.lastPageID == 4)
        #expect(reopened.isHapticsEnabled == false)
        #expect(reopened.hasSeenGuide)
    }

    @Test("Settings write straight through to the stored preferences")
    @MainActor
    func settingsWriteThrough() {
        let preferences = InMemoryPreferencesRepository()
        let settings = AppSettings(preferences: preferences)

        settings.isHapticsEnabled = false
        settings.lastPageID = 2
        settings.hasSeenGuide = true

        #expect(preferences.isHapticsEnabled == false)
        #expect(preferences.lastPageID == 2)
        #expect(preferences.hasSeenGuide)
    }
}
