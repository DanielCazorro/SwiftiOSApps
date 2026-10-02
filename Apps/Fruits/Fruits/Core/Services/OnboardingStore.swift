//
//  OnboardingStore.swift
//  Fruits
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Foundation
import Observation

@Observable
final class OnboardingStore {
    private static let key = "isOnboarding"

    private(set) var isOnboarding: Bool {
        didSet { defaults.set(isOnboarding, forKey: Self.key) }
    }

    @ObservationIgnored private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        isOnboarding = defaults.object(forKey: Self.key) as? Bool ?? true
    }

    func complete() {
        isOnboarding = false
    }

    func restart() {
        isOnboarding = true
    }
}
