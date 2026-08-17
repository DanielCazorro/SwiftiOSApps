//
//  Priority.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI

/// How urgently an item is needed. `rawValue` is persisted, so keep it stable.
enum Priority: Int, Codable, CaseIterable, Identifiable, Comparable, Sendable {
    case low = 0
    case medium = 1
    case high = 2

    var id: Int { rawValue }

    static func < (lhs: Priority, rhs: Priority) -> Bool { lhs.rawValue < rhs.rawValue }

    var name: LocalizedStringResource {
        switch self {
        case .low: "Low"
        case .medium: "Medium"
        case .high: "High"
        }
    }

    var symbol: String {
        switch self {
        case .low: "arrow.down"
        case .medium: "equal"
        case .high: "exclamationmark"
        }
    }

    var tint: Color {
        switch self {
        case .low: .green
        case .medium: .orange
        case .high: .red
        }
    }
}
