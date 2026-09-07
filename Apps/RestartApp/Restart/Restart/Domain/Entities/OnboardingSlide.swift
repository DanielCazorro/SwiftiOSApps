//
//  OnboardingSlide.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

struct OnboardingSlide: Identifiable, Hashable, Sendable {
    let id: Int
    let titleKey: String
    let messageKey: String
    let imageName: String
    let imageAccessibilityKey: String
}
