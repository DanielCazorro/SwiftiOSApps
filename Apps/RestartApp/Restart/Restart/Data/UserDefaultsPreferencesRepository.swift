//
//  UserDefaultsPreferencesRepository.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

final class UserDefaultsPreferencesRepository: PreferencesRepository {
    private enum Key {
        static let hasCompletedOnboarding = "preferences.hasCompletedOnboarding"
        static let isSoundEnabled = "preferences.isSoundEnabled"
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        defaults.register(defaults: [
            Key.hasCompletedOnboarding: false,
            Key.isSoundEnabled: true
        ])
    }

    var hasCompletedOnboarding: Bool {
        get { defaults.bool(forKey: Key.hasCompletedOnboarding) }
        set { defaults.set(newValue, forKey: Key.hasCompletedOnboarding) }
    }

    var isSoundEnabled: Bool {
        get { defaults.bool(forKey: Key.isSoundEnabled) }
        set { defaults.set(newValue, forKey: Key.isSoundEnabled) }
    }
}
