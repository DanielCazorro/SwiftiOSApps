//
//  OnboardingViewModel.swift
//  Restart
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class OnboardingViewModel {
    static let characterDragLimit: CGFloat = 150
    static let slideChangeThreshold: CGFloat = 80

    private let feedback: FeedbackPlaying
    private let settings: AppSettings

    let slides: [OnboardingSlide]
    private(set) var currentIndex = 0
    private(set) var characterOffset: CGFloat = 0
    private(set) var sliderOffset: CGFloat = 0

    init(
        content: OnboardingContentRepository,
        feedback: FeedbackPlaying,
        settings: AppSettings
    ) {
        self.slides = content.allSlides()
        self.feedback = feedback
        self.settings = settings
        assert(!slides.isEmpty, "The onboarding needs at least one slide")
    }

    var currentSlide: OnboardingSlide { slides[currentIndex] }
    var isLastSlide: Bool { currentIndex == slides.index(before: slides.endIndex) }
    var isDragHintVisible: Bool { characterOffset == 0 }

    // MARK: - Character drag

    func dragCharacter(by translation: CGFloat) {
        characterOffset = min(max(translation, -Self.characterDragLimit), Self.characterDragLimit)
    }

    func endCharacterDrag() {
        defer { characterOffset = 0 }

        if characterOffset <= -Self.slideChangeThreshold {
            move(to: currentIndex + 1)
        } else if characterOffset >= Self.slideChangeThreshold {
            move(to: currentIndex - 1)
        }
    }

    func move(to index: Int) {
        guard slides.indices.contains(index), index != currentIndex else { return }
        currentIndex = index
        sliderOffset = 0
        feedback.vibrate(.selection)
    }

    // MARK: - Slide to start

    func maximumSliderOffset(trackWidth: CGFloat) -> CGFloat {
        max(trackWidth - Layout.knobSize, 0)
    }

    func dragSlider(by translation: CGFloat, trackWidth: CGFloat) {
        sliderOffset = min(max(translation, 0), maximumSliderOffset(trackWidth: trackWidth))
    }

    func endSliderDrag(trackWidth: CGFloat) {
        let maximum = maximumSliderOffset(trackWidth: trackWidth)
        guard maximum > 0, sliderOffset > maximum / 2 else {
            sliderOffset = 0
            feedback.vibrate(.warning)
            return
        }
        sliderOffset = maximum
        complete()
    }

    func complete() {
        feedback.vibrate(.success)
        feedback.play(.unlock)
        settings.hasCompletedOnboarding = true
    }
}
