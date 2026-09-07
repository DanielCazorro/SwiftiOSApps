//
//  BundledOnboardingContentRepository.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

struct BundledOnboardingContentRepository: OnboardingContentRepository {
    func allSlides() -> [OnboardingSlide] {
        [
            OnboardingSlide(
                id: 0,
                titleKey: "onboarding.share.title",
                messageKey: "onboarding.share.message",
                imageName: "character-1",
                imageAccessibilityKey: "onboarding.share.image"
            ),
            OnboardingSlide(
                id: 1,
                titleKey: "onboarding.give.title",
                messageKey: "onboarding.give.message",
                imageName: "character-2",
                imageAccessibilityKey: "onboarding.give.image"
            ),
            OnboardingSlide(
                id: 2,
                titleKey: "onboarding.restart.title",
                messageKey: "onboarding.restart.message",
                imageName: "character-1",
                imageAccessibilityKey: "onboarding.restart.image"
            )
        ]
    }
}
