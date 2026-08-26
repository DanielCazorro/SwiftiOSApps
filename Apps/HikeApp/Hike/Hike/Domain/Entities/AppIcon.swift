//
//  AppIcon.swift
//  Hike
//
//  Created by Daniel Cazorro on 23/08/2026.
//

import Foundation

enum AppIcon: String, CaseIterable, Identifiable, Sendable {
    case primary = "AppIcon"
    case magnifyingGlass = "AppIcon-MagnifyingGlass"
    case map = "AppIcon-Map"
    case mushroom = "AppIcon-Mushroom"
    case camera = "AppIcon-Camera"
    case backpack = "AppIcon-Backpack"
    case campfire = "AppIcon-Campfire"

    var id: String { rawValue }

    var alternateIconName: String? {
        self == .primary ? nil : rawValue
    }

    var previewImageName: String {
        self == .primary ? "AppIcon-Default-Preview" : "\(rawValue)-Preview"
    }

    var localizationKey: String {
        switch self {
        case .primary: "appIcon.default"
        case .magnifyingGlass: "appIcon.magnifyingGlass"
        case .map: "appIcon.map"
        case .mushroom: "appIcon.mushroom"
        case .camera: "appIcon.camera"
        case .backpack: "appIcon.backpack"
        case .campfire: "appIcon.campfire"
        }
    }

    init(alternateIconName: String?) {
        guard let alternateIconName,
              let icon = AppIcon(rawValue: alternateIconName) else {
            self = .primary
            return
        }
        self = icon
    }
}
