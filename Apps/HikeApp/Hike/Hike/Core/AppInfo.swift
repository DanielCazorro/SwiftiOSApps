//
//  AppInfo.swift
//  Hike
//
//  Created by Daniel Cazorro on 24/08/2026.
//

import Foundation

/// Read-only facts about the running bundle, so the About section never drifts out of sync
/// with the values configured in the build settings.
enum AppInfo {
    static var name: String {
        bundleString(for: "CFBundleDisplayName")
            ?? bundleString(for: kCFBundleNameKey as String)
            ?? "Hike"
    }

    /// Marketing version, e.g. `1.0`.
    static var version: String {
        bundleString(for: "CFBundleShortVersionString") ?? "—"
    }

    /// Build number, e.g. `1`.
    static var build: String {
        bundleString(for: kCFBundleVersionKey as String) ?? "—"
    }

    /// `1.0 (1)`
    static var fullVersion: String { "\(version) (\(build))" }

    /// Credited on the About screen and in the copyright line.
    static let author = "Daniel Cazorro"

    /// Shown as the contact row's label; the tappable URL lives in ``AppLinks/contact``.
    static let contactEmail = "dani@outlook.com"

    static var currentYear: String {
        Date.now.formatted(.dateTime.year())
    }

    private static func bundleString(for key: String) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String,
              !value.isEmpty else { return nil }
        return value
    }
}
