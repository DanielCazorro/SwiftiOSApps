//
//  AppSettings.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import Observation

@MainActor
@Observable
final class AppSettings {
    @ObservationIgnored private let preferences: PreferencesRepository

    init(preferences: PreferencesRepository) {
        self.preferences = preferences
    }

    var lastPageID: Int? {
        get { access(keyPath: \.lastPageID); return preferences.lastPageID }
        set { withMutation(keyPath: \.lastPageID) { preferences.lastPageID = newValue } }
    }

    var isHapticsEnabled: Bool {
        get { access(keyPath: \.isHapticsEnabled); return preferences.isHapticsEnabled }
        set { withMutation(keyPath: \.isHapticsEnabled) { preferences.isHapticsEnabled = newValue } }
    }

    var hasSeenGuide: Bool {
        get { access(keyPath: \.hasSeenGuide); return preferences.hasSeenGuide }
        set { withMutation(keyPath: \.hasSeenGuide) { preferences.hasSeenGuide = newValue } }
    }
}
