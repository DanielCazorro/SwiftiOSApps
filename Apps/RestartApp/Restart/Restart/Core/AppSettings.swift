//
//  AppSettings.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class AppSettings {
    private let preferences: PreferencesRepository

    var hasCompletedOnboarding: Bool {
        didSet { preferences.hasCompletedOnboarding = hasCompletedOnboarding }
    }

    var isSoundEnabled: Bool {
        didSet { preferences.isSoundEnabled = isSoundEnabled }
    }

    init(preferences: PreferencesRepository) {
        self.preferences = preferences
        self.hasCompletedOnboarding = preferences.hasCompletedOnboarding
        self.isSoundEnabled = preferences.isSoundEnabled
    }
}
