//
//  ViewerViewModel.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics
import Observation

@MainActor
@Observable
final class ViewerViewModel {
    static let pageTurnThreshold: CGFloat = 80

    @ObservationIgnored private let haptics: HapticsPlaying
    @ObservationIgnored private let settings: AppSettings

    private(set) var pages: [Page]
    private(set) var currentPageID: Page.ID
    private(set) var zoom = ZoomState()
    private(set) var viewportSize: CGSize = .zero
    private(set) var pageTurnTranslation: CGFloat = 0

    var isDrawerOpen = false
    var isGuidePresented = false

    private var panBase: CGSize = .zero
    private var isPanning = false
    private var magnifyBase: CGFloat = ZoomState.minScale
    private var isMagnifying = false

    init(pageRepository: PageRepository, haptics: HapticsPlaying, settings: AppSettings) {
        let pages = pageRepository.allPages()
        assert(!pages.isEmpty, "The viewer needs at least one page")
        self.pages = pages
        self.haptics = haptics
        self.settings = settings
        self.currentPageID = pages.first(where: { $0.id == settings.lastPageID })?.id ?? pages.first?.id ?? 0
    }

    // MARK: - Pages

    var currentPage: Page {
        pages.first(where: { $0.id == currentPageID }) ?? pages[0]
    }

    var currentIndex: Int {
        pages.firstIndex(where: { $0.id == currentPageID }) ?? 0
    }

    var canShowNextPage: Bool { currentIndex < pages.count - 1 }
    var canShowPreviousPage: Bool { currentIndex > 0 }

    func showNextPage() {
        guard canShowNextPage else {
            haptics.play(.limit)
            return
        }
        select(pageID: pages[currentIndex + 1].id)
    }

    func showPreviousPage() {
        guard canShowPreviousPage else {
            haptics.play(.limit)
            return
        }
        select(pageID: pages[currentIndex - 1].id)
    }

    func select(pageID: Page.ID) {
        guard pageID != currentPageID, pages.contains(where: { $0.id == pageID }) else { return }
        currentPageID = pageID
        settings.lastPageID = pageID
        zoom.reset()
        haptics.play(.success)
    }

    // MARK: - Viewport

    var viewport: Viewport {
        Viewport(size: viewportSize, contentAspectRatio: currentPage.aspectRatio)
    }

    func viewportChanged(to size: CGSize) {
        guard size != viewportSize else { return }
        viewportSize = size
        zoom.settle(in: viewport)
    }

    // MARK: - Zoom controls

    func zoomIn() {
        guard zoom.canZoomIn else {
            haptics.play(.limit)
            return
        }
        zoom.zoomIn(in: viewport)
        haptics.play(.selection)
    }

    func zoomOut() {
        guard zoom.canZoomOut else {
            haptics.play(.limit)
            return
        }
        zoom.zoomOut(in: viewport)
        haptics.play(.selection)
    }

    func resetZoom() {
        guard zoom.isZoomedIn else { return }
        zoom.reset()
        haptics.play(.selection)
    }

    func handleDoubleTap(at point: CGPoint) {
        zoom.toggleZoom(around: point, in: viewport)
        haptics.play(.selection)
    }

    // MARK: - Pinch

    func magnificationChanged(to magnification: CGFloat, anchor: CGPoint) {
        if !isMagnifying {
            isMagnifying = true
            magnifyBase = zoom.scale
        }
        zoom.magnify(base: magnifyBase, by: magnification, around: anchor, in: viewport)
    }

    func magnificationEnded() {
        guard isMagnifying else { return }
        isMagnifying = false
        magnifyBase = zoom.scale
        haptics.play(.selection)
    }

    // MARK: - Drag: pans when zoomed in, turns the page when fitted

    func dragChanged(translation: CGSize) {
        if zoom.isZoomedIn {
            if !isPanning {
                isPanning = true
                panBase = zoom.offset
            }
            zoom.pan(from: panBase, by: translation, in: viewport)
        } else {
            pageTurnTranslation = resistedTranslation(translation.width)
        }
    }

    func dragEnded(translation: CGSize) {
        let wasPanning = isPanning
        isPanning = false
        pageTurnTranslation = 0
        guard !wasPanning, !zoom.isZoomedIn else { return }

        if translation.width <= -Self.pageTurnThreshold {
            showNextPage()
        } else if translation.width >= Self.pageTurnThreshold {
            showPreviousPage()
        }
    }

    private func resistedTranslation(_ width: CGFloat) -> CGFloat {
        let hasSomewhereToGo = width < 0 ? canShowNextPage : canShowPreviousPage
        return width * (hasSomewhereToGo ? 0.4 : 0.12)
    }

    // MARK: - Chrome

    func toggleDrawer() {
        isDrawerOpen.toggle()
        haptics.play(.selection)
    }

    func showGuide() {
        isGuidePresented = true
    }

    func onAppear() {
        if !settings.hasSeenGuide {
            isGuidePresented = true
        }
    }

    func guideDismissed() {
        isGuidePresented = false
        settings.hasSeenGuide = true
    }
}
