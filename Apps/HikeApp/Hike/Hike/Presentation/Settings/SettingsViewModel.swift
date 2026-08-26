//
//  SettingsViewModel.swift
//  Hike
//
//  Created by Daniel Cazorro on 23/08/2026.
//

import Foundation
import Observation
import OSLog

@MainActor
@Observable
final class SettingsViewModel {
    private let appIconRepository: AppIconRepository
    private let logger = Logger(subsystem: "com.DanielCazorro.Hike", category: "Settings")
    private(set) var selectedIcon: AppIcon
    var iconChangeErrorMessage: String?
    let icons = AppIcon.allCases

    init(appIconRepository: AppIconRepository = SystemAppIconRepository()) {
        self.appIconRepository = appIconRepository
        self.selectedIcon = appIconRepository.currentIcon
    }

    var supportsAlternateIcons: Bool { appIconRepository.supportsAlternateIcons }

    var appVersion: String { AppInfo.fullVersion }

    var isPresentingIconError: Bool {
        get { iconChangeErrorMessage != nil }
        set { if !newValue { iconChangeErrorMessage = nil } }
    }

    func selectIcon(_ icon: AppIcon) async {
        guard icon != selectedIcon else { return }
        let previousIcon = selectedIcon
        selectedIcon = icon
        do {
            try await appIconRepository.setIcon(icon)
            logger.info("App icon changed to \(icon.rawValue, privacy: .public)")
        } catch {
            selectedIcon = previousIcon
            iconChangeErrorMessage = error.localizedDescription
            logger.error("Failed to change the app icon: \(error.localizedDescription, privacy: .public)")
        }
    }
}
