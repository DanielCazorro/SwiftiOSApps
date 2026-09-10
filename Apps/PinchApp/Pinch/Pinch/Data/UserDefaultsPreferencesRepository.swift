//
//  UserDefaultsPreferencesRepository.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import Foundation

final class UserDefaultsPreferencesRepository: PreferencesRepository {
    private enum Key {
        static let lastPageID = "viewer.lastPageID"
        static let haptics = "settings.haptics"
        static let hasSeenGuide = "guide.hasBeenSeen"
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        defaults.register(defaults: [Key.haptics: true])
    }

    var lastPageID: Int? {
        get { defaults.object(forKey: Key.lastPageID) as? Int }
        set { defaults.set(newValue, forKey: Key.lastPageID) }
    }

    var isHapticsEnabled: Bool {
        get { defaults.bool(forKey: Key.haptics) }
        set { defaults.set(newValue, forKey: Key.haptics) }
    }

    var hasSeenGuide: Bool {
        get { defaults.bool(forKey: Key.hasSeenGuide) }
        set { defaults.set(newValue, forKey: Key.hasSeenGuide) }
    }
}
