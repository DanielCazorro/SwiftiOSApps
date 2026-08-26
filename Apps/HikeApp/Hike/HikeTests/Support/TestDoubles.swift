//
//  TestDoubles.swift
//  HikeTests
//
//  Created by Daniel Cazorro on 26/08/2026.
//

import Foundation
@testable import Hike

struct StubHikeRepository: HikeRepository {
    var hikes: [Hike]

    init(hikes: [Hike]) { self.hikes = hikes }

    init(count: Int) {
        hikes = (0..<max(count, 0)).map { offset in
            let index = offset + 1
            return Hike(
                id: index,
                imageName: "image-\(index)",
                nameKey: "hike.\(index).name",
                locationKey: "hike.\(index).location",
                distanceInKilometers: Double(index),
                elevationGainInMeters: Double(index * 100),
                difficulty: .moderate
            )
        }
    }

    func allHikes() -> [Hike] { hikes }
}

struct StubError: LocalizedError {
    var errorDescription: String?
}

@MainActor
final class StubAppIconRepository: AppIconRepository {
    var supportsAlternateIcons: Bool
    private(set) var currentIcon: AppIcon
    var errorToThrow: (any Error)?
    private(set) var setIconCallCount = 0

    init(currentIcon: AppIcon = .primary, supportsAlternateIcons: Bool = true) {
        self.currentIcon = currentIcon
        self.supportsAlternateIcons = supportsAlternateIcons
    }

    func setIcon(_ icon: AppIcon) async throws {
        setIconCallCount += 1
        if let errorToThrow { throw errorToThrow }
        currentIcon = icon
    }
}

extension UserDefaults {
    static func makeEphemeral(function: String = #function) -> UserDefaults {
        let suite = "HikeTests.\(function).\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defaults.removePersistentDomain(forName: suite)
        return defaults
    }
}
