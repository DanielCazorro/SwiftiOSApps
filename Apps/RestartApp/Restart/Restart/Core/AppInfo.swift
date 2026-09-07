//
//  AppInfo.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

enum AppInfo {
    static var name: String {
        bundleString(for: "CFBundleDisplayName") ?? bundleString(for: kCFBundleNameKey as String) ?? "Restart"
    }

    static var version: String {
        bundleString(for: "CFBundleShortVersionString") ?? "—"
    }

    static var build: String {
        bundleString(for: kCFBundleVersionKey as String) ?? "—"
    }

    static var fullVersion: String { "\(version) (\(build))" }

    static let author = "Daniel Cazorro"

    private static func bundleString(for key: String) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String, !value.isEmpty else { return nil }
        return value
    }
}
