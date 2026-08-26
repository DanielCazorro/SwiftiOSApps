//
//  HikeDifficulty.swift
//  Hike
//
//  Created by Daniel Cazorro on 20/08/2026.
//

import Foundation

enum HikeDifficulty: String, CaseIterable, Comparable, Sendable {
    case easy
    case moderate
    case challenging

    var localizationKey: String { "difficulty.\(rawValue)" }

    var symbolName: String {
        switch self {
        case .easy: "figure.walk"
        case .moderate: "figure.hiking"
        case .challenging: "mountain.2.fill"
        }
    }

    static func < (lhs: HikeDifficulty, rhs: HikeDifficulty) -> Bool {
        guard let lhsIndex = allCases.firstIndex(of: lhs),
              let rhsIndex = allCases.firstIndex(of: rhs) else { return false }
        return lhsIndex < rhsIndex
    }
}
