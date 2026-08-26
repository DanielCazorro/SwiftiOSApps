//
//  SystemAppIconRepository.swift
//  Hike
//
//  Created by Daniel Cazorro on 23/08/2026.
//

import UIKit

@MainActor
struct SystemAppIconRepository: AppIconRepository {
    private let application: UIApplication

    init(application: UIApplication = .shared) {
        self.application = application
    }

    var supportsAlternateIcons: Bool {
        application.supportsAlternateIcons
    }

    var currentIcon: AppIcon {
        AppIcon(alternateIconName: application.alternateIconName)
    }

    func setIcon(_ icon: AppIcon) async throws {
        guard icon != currentIcon else { return }
        try await application.setAlternateIconName(icon.alternateIconName)
    }
}
