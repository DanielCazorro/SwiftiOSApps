//
//  TestDoubles.swift
//  PinchTests
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics
import Foundation
@testable import Pinch

@MainActor
final class SpyHapticsPlayer: HapticsPlaying {
    private(set) var played: [HapticFeedback] = []
    private(set) var prepareCount = 0

    func play(_ feedback: HapticFeedback) { played.append(feedback) }
    func prepare() { prepareCount += 1 }
}

struct StubPageRepository: PageRepository {
    let pages: [Page]

    func allPages() -> [Page] { pages }

    /// Pages whose aspect ratio matches the test viewport, so the fitted page
    /// fills it exactly and the offset limits are easy to reason about.
    static func make(count: Int, aspectRatio: CGFloat = 0.5) -> StubPageRepository {
        StubPageRepository(pages: (1...count).map { index in
            Page(
                id: index,
                imageName: "page-\(index)",
                titleKey: "page.\(index).title",
                captionKey: "page.\(index).caption",
                aspectRatio: aspectRatio
            )
        })
    }
}

@MainActor
struct TestEnvironment {
    static let viewportSize = CGSize(width: 300, height: 600)

    let viewer: ViewerViewModel
    let haptics: SpyHapticsPlayer
    let settings: AppSettings
    let preferences: InMemoryPreferencesRepository

    static func make(
        pageCount: Int = 3,
        lastPageID: Int? = nil,
        hasSeenGuide: Bool = true,
        viewportSize: CGSize? = TestEnvironment.viewportSize
    ) -> TestEnvironment {
        let preferences = InMemoryPreferencesRepository(lastPageID: lastPageID, hasSeenGuide: hasSeenGuide)
        let settings = AppSettings(preferences: preferences)
        let haptics = SpyHapticsPlayer()
        let viewer = ViewerViewModel(
            pageRepository: StubPageRepository.make(count: pageCount),
            haptics: haptics,
            settings: settings
        )
        if let viewportSize {
            viewer.viewportChanged(to: viewportSize)
        }
        return TestEnvironment(viewer: viewer, haptics: haptics, settings: settings, preferences: preferences)
    }
}

extension ViewerViewModel {
    func drag(by translation: CGSize) {
        dragChanged(translation: translation)
        dragEnded(translation: translation)
    }
}
