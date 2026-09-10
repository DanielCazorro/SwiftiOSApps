//
//  AppDependencies.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

@MainActor
struct AppDependencies {
    let settings: AppSettings
    let haptics: HapticsPlaying
    let pages: PageRepository

    init(preferences: PreferencesRepository = UserDefaultsPreferencesRepository()) {
        self.settings = AppSettings(preferences: preferences)
        self.haptics = SystemHapticsPlayer(preferences: preferences)
        self.pages = BundledPageRepository()
    }

    init(settings: AppSettings, haptics: HapticsPlaying, pages: PageRepository) {
        self.settings = settings
        self.haptics = haptics
        self.pages = pages
    }
}

extension AppDependencies {
    static var preview: AppDependencies {
        AppDependencies(preferences: InMemoryPreferencesRepository())
    }
}

final class InMemoryPreferencesRepository: PreferencesRepository {
    var lastPageID: Int?
    var isHapticsEnabled: Bool
    var hasSeenGuide: Bool

    init(lastPageID: Int? = nil, isHapticsEnabled: Bool = true, hasSeenGuide: Bool = true) {
        self.lastPageID = lastPageID
        self.isHapticsEnabled = isHapticsEnabled
        self.hasSeenGuide = hasSeenGuide
    }
}
