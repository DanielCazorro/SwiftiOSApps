//
//  PreferencesTests.swift
//  RestartTests
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Testing
@testable import Restart

@Suite("Preferences")
struct PreferencesTests {
    private func makeDefaults() throws -> UserDefaults {
        let suite = try #require(UserDefaults(suiteName: "RestartTests.\(UUID().uuidString)"))
        return suite
    }

    @Test("Sound is on and onboarding pending on a fresh install")
    func defaultsAreSensible() throws {
        let repository = UserDefaultsPreferencesRepository(defaults: try makeDefaults())

        #expect(repository.hasCompletedOnboarding == false)
        #expect(repository.isSoundEnabled)
    }

    @Test("Values survive a new repository over the same storage")
    func valuesPersist() throws {
        let defaults = try makeDefaults()
        let repository = UserDefaultsPreferencesRepository(defaults: defaults)

        repository.hasCompletedOnboarding = true
        repository.isSoundEnabled = false

        let reloaded = UserDefaultsPreferencesRepository(defaults: defaults)
        #expect(reloaded.hasCompletedOnboarding)
        #expect(reloaded.isSoundEnabled == false)
    }

    @MainActor
    @Test("AppSettings writes every change through to the repository")
    func appSettingsWritesThrough() {
        let preferences = InMemoryPreferencesRepository()
        let settings = AppSettings(preferences: preferences)

        settings.hasCompletedOnboarding = true
        settings.isSoundEnabled = false

        #expect(preferences.hasCompletedOnboarding)
        #expect(preferences.isSoundEnabled == false)
    }
}
