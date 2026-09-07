//
//  OnboardingViewModelTests.swift
//  RestartTests
//
//  Created by Daniel Cazorro on 07/09/2026.
//

import Foundation
import Testing
@testable import Restart

@MainActor
@Suite("Onboarding")
struct OnboardingViewModelTests {
    @Test("It starts on the first slide")
    func startsOnFirstSlide() {
        let env = TestEnvironment.make()
        #expect(env.onboarding.currentIndex == 0)
        #expect(env.onboarding.isLastSlide == false)
        #expect(env.onboarding.isDragHintVisible)
    }

    @Test("Dragging the character never goes past the limit")
    func characterDragIsClamped() {
        let env = TestEnvironment.make()
        let limit = OnboardingViewModel.characterDragLimit

        env.onboarding.dragCharacter(by: limit * 10)
        #expect(env.onboarding.characterOffset == limit)

        env.onboarding.dragCharacter(by: -limit * 10)
        #expect(env.onboarding.characterOffset == -limit)
    }

    @Test("A drag shorter than the threshold snaps back without changing slide")
    func shortDragDoesNotChangeSlide() {
        let env = TestEnvironment.make()

        env.onboarding.dragCharacter(by: -(OnboardingViewModel.slideChangeThreshold - 1))
        env.onboarding.endCharacterDrag()

        #expect(env.onboarding.currentIndex == 0)
        #expect(env.onboarding.characterOffset == 0)
        #expect(env.feedback.vibrations.isEmpty)
    }

    @Test("Dragging left advances and dragging right goes back")
    func dragMovesBetweenSlides() {
        let env = TestEnvironment.make()
        let threshold = OnboardingViewModel.slideChangeThreshold

        env.onboarding.dragCharacter(by: -threshold)
        env.onboarding.endCharacterDrag()
        #expect(env.onboarding.currentIndex == 1)

        env.onboarding.dragCharacter(by: threshold)
        env.onboarding.endCharacterDrag()
        #expect(env.onboarding.currentIndex == 0)
        #expect(env.feedback.vibrations == [.selection, .selection])
    }

    @Test("The flow never runs off either end")
    func indexStaysInBounds() {
        let env = TestEnvironment.make(slideCount: 3)

        env.onboarding.move(to: -1)
        #expect(env.onboarding.currentIndex == 0)

        env.onboarding.move(to: 2)
        #expect(env.onboarding.isLastSlide)

        env.onboarding.move(to: 3)
        #expect(env.onboarding.currentIndex == 2)
    }

    @Test("The knob stays inside its track")
    func sliderIsClamped() {
        let env = TestEnvironment.make()
        let trackWidth: CGFloat = 300
        let maximum = env.onboarding.maximumSliderOffset(trackWidth: trackWidth)

        #expect(maximum == trackWidth - Layout.knobSize)

        env.onboarding.dragSlider(by: -500, trackWidth: trackWidth)
        #expect(env.onboarding.sliderOffset == 0)

        env.onboarding.dragSlider(by: 500, trackWidth: trackWidth)
        #expect(env.onboarding.sliderOffset == maximum)
    }

    @Test("Releasing before halfway springs back and warns")
    func sliderBelowHalfwaySpringsBack() {
        let env = TestEnvironment.make()
        let trackWidth: CGFloat = 300

        env.onboarding.dragSlider(by: 40, trackWidth: trackWidth)
        env.onboarding.endSliderDrag(trackWidth: trackWidth)

        #expect(env.onboarding.sliderOffset == 0)
        #expect(env.settings.hasCompletedOnboarding == false)
        #expect(env.feedback.vibrations == [.warning])
        #expect(env.feedback.playedSounds.isEmpty)
    }

    @Test("Releasing past halfway completes the onboarding")
    func sliderPastHalfwayCompletes() {
        let env = TestEnvironment.make()
        let trackWidth: CGFloat = 300
        let maximum = env.onboarding.maximumSliderOffset(trackWidth: trackWidth)

        env.onboarding.dragSlider(by: maximum, trackWidth: trackWidth)
        env.onboarding.endSliderDrag(trackWidth: trackWidth)

        #expect(env.onboarding.sliderOffset == maximum)
        #expect(env.settings.hasCompletedOnboarding)
        #expect(env.feedback.vibrations == [.success])
        #expect(env.feedback.playedSounds == [.unlock])
    }

    @Test("The accessibility action completes without any drag")
    func accessibilityActionCompletes() {
        let env = TestEnvironment.make()

        env.onboarding.complete()

        #expect(env.settings.hasCompletedOnboarding)
        #expect(env.feedback.playedSounds == [.unlock])
    }

    @Test("Changing slide resets a half-finished drag on the knob")
    func changingSlideResetsSlider() {
        let env = TestEnvironment.make()
        env.onboarding.move(to: 2)
        env.onboarding.dragSlider(by: 100, trackWidth: 300)

        env.onboarding.move(to: 1)

        #expect(env.onboarding.sliderOffset == 0)
    }
}
