//
//  OnboardingContentRepository.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation

protocol OnboardingContentRepository: Sendable {
    func allSlides() -> [OnboardingSlide]
}
