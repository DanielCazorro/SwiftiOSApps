//
//  ViewerViewModelTests.swift
//  PinchTests
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics
import Testing
@testable import Pinch

@MainActor
@Suite("Viewer")
struct ViewerViewModelTests {
    // MARK: - Pages

    @Test("The reader comes back to the page they left off on")
    func restoresTheLastPage() {
        let env = TestEnvironment.make(pageCount: 3, lastPageID: 2)

        #expect(env.viewer.currentPageID == 2)
    }

    @Test("An unknown stored page falls back to the first one")
    func fallsBackToTheFirstPage() {
        let env = TestEnvironment.make(pageCount: 3, lastPageID: 99)

        #expect(env.viewer.currentPageID == 1)
    }

    @Test("Opening a page stores it and starts it fitted to the screen")
    func selectingAPageResetsZoomAndPersists() {
        let env = TestEnvironment.make()
        env.viewer.zoomIn()

        env.viewer.select(pageID: 3)

        #expect(env.viewer.currentPageID == 3)
        #expect(env.settings.lastPageID == 3)
        #expect(env.viewer.zoom.isZoomedIn == false)
        #expect(env.haptics.played.contains(.success))
    }

    @Test("Re-opening the page already on screen changes nothing")
    func selectingTheSamePageIsANoOp() {
        let env = TestEnvironment.make()
        env.viewer.zoomIn()

        env.viewer.select(pageID: env.viewer.currentPageID)

        #expect(env.viewer.zoom.isZoomedIn)
        #expect(env.haptics.played.contains(.success) == false)
    }

    @Test("Page turning stops at both ends of the magazine")
    func pageTurningStopsAtTheEnds() {
        let env = TestEnvironment.make(pageCount: 2)

        env.viewer.showPreviousPage()
        #expect(env.viewer.currentIndex == 0)
        #expect(env.haptics.played.last == .limit)

        env.viewer.showNextPage()
        #expect(env.viewer.currentIndex == 1)
        #expect(env.viewer.canShowNextPage == false)

        env.viewer.showNextPage()
        #expect(env.viewer.currentIndex == 1)
        #expect(env.haptics.played.last == .limit)
    }

    // MARK: - Dragging

    @Test("A long enough swipe turns the page")
    func swipingTurnsThePage() {
        let env = TestEnvironment.make(pageCount: 3)

        env.viewer.drag(by: CGSize(width: -ViewerViewModel.pageTurnThreshold - 1, height: 0))
        #expect(env.viewer.currentIndex == 1)

        env.viewer.drag(by: CGSize(width: ViewerViewModel.pageTurnThreshold + 1, height: 0))
        #expect(env.viewer.currentIndex == 0)
    }

    @Test("A short swipe leaves the page where it is")
    func shortSwipesAreIgnored() {
        let env = TestEnvironment.make(pageCount: 3)

        env.viewer.drag(by: CGSize(width: -ViewerViewModel.pageTurnThreshold + 1, height: 0))

        #expect(env.viewer.currentIndex == 0)
        #expect(env.viewer.pageTurnTranslation == 0)
    }

    @Test("The page follows the finger, and pushes back when there is nowhere to go")
    func dragResistanceDependsOnWhereThePageCanGo() {
        let env = TestEnvironment.make(pageCount: 2)

        env.viewer.dragChanged(translation: CGSize(width: -100, height: 0))
        let towardsNextPage = env.viewer.pageTurnTranslation

        env.viewer.dragChanged(translation: CGSize(width: 100, height: 0))
        let towardsNothing = env.viewer.pageTurnTranslation

        #expect(towardsNextPage < 0)
        #expect(towardsNothing > 0)
        #expect(abs(towardsNothing) < abs(towardsNextPage))
    }

    @Test("Dragging a zoomed page pans it instead of turning the page")
    func draggingWhileZoomedPans() {
        let env = TestEnvironment.make(pageCount: 3)
        env.viewer.zoomIn()

        env.viewer.drag(by: CGSize(width: -200, height: -50))

        #expect(env.viewer.currentIndex == 0)
        #expect(env.viewer.zoom.offset == CGSize(width: -150, height: -50))
    }

    @Test("Panning never pulls the page away from the edge of the screen")
    func panningIsClamped() {
        let env = TestEnvironment.make()
        env.viewer.zoomIn()

        env.viewer.drag(by: CGSize(width: 5_000, height: 5_000))

        #expect(env.viewer.zoom.offset == CGSize(width: 150, height: 300))
    }

    // MARK: - Zooming

    @Test("The zoom controls step up to the maximum and then say so")
    func zoomingInStopsAtTheMaximum() {
        let env = TestEnvironment.make()

        for _ in 0..<10 { env.viewer.zoomIn() }

        #expect(env.viewer.zoom.scale == ZoomState.maxScale)
        #expect(env.viewer.zoom.canZoomIn == false)
        #expect(env.haptics.played.last == .limit)
    }

    @Test("Zooming out of a fitted page only reports the limit")
    func zoomingOutOfAFittedPageDoesNothing() {
        let env = TestEnvironment.make()

        env.viewer.zoomOut()

        #expect(env.viewer.zoom.scale == ZoomState.minScale)
        #expect(env.haptics.played == [.limit])
    }

    @Test("A pinch keeps building on the scale it started from")
    func pinchingIsRelativeToTheStartOfTheGesture() {
        let env = TestEnvironment.make()
        let anchor = CGPoint(x: 150, y: 300)

        env.viewer.magnificationChanged(to: 2, anchor: anchor)
        #expect(env.viewer.zoom.scale == 2)

        // Same gesture, the reader eases off a little.
        env.viewer.magnificationChanged(to: 1.5, anchor: anchor)
        #expect(env.viewer.zoom.scale == 1.5)
        env.viewer.magnificationEnded()

        // A brand new pinch starts from where the previous one left off.
        env.viewer.magnificationChanged(to: 2, anchor: anchor)
        #expect(env.viewer.zoom.scale == 3)
    }

    @Test("Fitting the page again clears the zoom")
    func resettingClearsTheZoom() {
        let env = TestEnvironment.make()
        env.viewer.zoomIn()
        env.viewer.dragChanged(translation: CGSize(width: 40, height: 40))

        env.viewer.resetZoom()

        #expect(env.viewer.zoom.scale == ZoomState.minScale)
        #expect(env.viewer.zoom.offset == .zero)
    }

    @Test("A rotation pulls the zoomed page back inside the new bounds")
    func viewportChangesReSettleThePage() {
        let env = TestEnvironment.make()
        env.viewer.zoomIn()
        env.viewer.drag(by: CGSize(width: 5_000, height: 5_000))

        env.viewer.viewportChanged(to: CGSize(width: 200, height: 400))

        #expect(env.viewer.zoom.offset == CGSize(width: 100, height: 200))
    }

    // MARK: - Guide

    @Test("The guide introduces itself on the first launch only")
    func guideIsShownOnce() {
        let first = TestEnvironment.make(hasSeenGuide: false)
        first.viewer.onAppear()
        #expect(first.viewer.isGuidePresented)

        first.viewer.guideDismissed()
        #expect(first.settings.hasSeenGuide)
        #expect(first.viewer.isGuidePresented == false)

        let returning = TestEnvironment.make(hasSeenGuide: true)
        returning.viewer.onAppear()
        #expect(returning.viewer.isGuidePresented == false)
    }

    @Test("The guide can always be opened by hand")
    func guideCanBeOpenedManually() {
        let env = TestEnvironment.make()

        env.viewer.showGuide()

        #expect(env.viewer.isGuidePresented)
    }
}
