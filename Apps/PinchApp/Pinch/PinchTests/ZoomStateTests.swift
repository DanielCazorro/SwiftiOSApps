//
//  ZoomStateTests.swift
//  PinchTests
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics
import Testing
@testable import Pinch

@Suite("Zoom state")
struct ZoomStateTests {
    /// A 300x600 viewport showing a page of the same shape: the fitted page fills
    /// the viewport, so the offset limit at scale s is (150(s-1), 300(s-1)).
    private let viewport = Viewport(size: CGSize(width: 300, height: 600), contentAspectRatio: 0.5)

    @Test("A fresh state shows the page fitted and centred")
    func startsFitted() {
        let zoom = ZoomState()

        #expect(zoom.scale == ZoomState.minScale)
        #expect(zoom.offset == .zero)
        #expect(zoom.isZoomedIn == false)
        #expect(zoom.canZoomOut == false)
        #expect(zoom.canZoomIn)
        #expect(zoom.percentage == 100)
    }

    @Test("Scale never leaves the allowed range", arguments: [
        (99.0, ZoomState.maxScale), (0.2, ZoomState.minScale), (-4.0, ZoomState.minScale), (3.0, 3.0)
    ] as [(CGFloat, CGFloat)])
    func clampsScale(requested: CGFloat, expected: CGFloat) {
        var zoom = ZoomState()
        zoom.zoom(to: requested, in: viewport)

        #expect(zoom.scale == expected)
    }

    @Test("A scale that is not a number falls back to the fitted page")
    func handlesNonFiniteScale() {
        var zoom = ZoomState(scale: 2)
        zoom.zoom(to: .nan, in: viewport)

        #expect(zoom.scale == ZoomState.minScale)
    }

    @Test("The controls step through whole zoom levels")
    func steppingSnapsToWholeLevels() {
        var zoom = ZoomState()

        zoom.zoomIn(in: viewport)
        #expect(zoom.scale == 2)

        zoom.magnify(base: 2, by: 1.2, around: viewport.center, in: viewport)
        #expect(zoom.scale == 2.4)

        zoom.zoomIn(in: viewport)
        #expect(zoom.scale == 3)

        zoom.magnify(base: 3, by: 0.8, around: viewport.center, in: viewport)
        zoom.zoomOut(in: viewport)
        #expect(zoom.scale == 2)
    }

    @Test("Zooming out past the bottom leaves the page fitted and centred")
    func zoomingOutFitsThePage() {
        var zoom = ZoomState(scale: 1.5, offset: CGSize(width: 40, height: 40))

        zoom.zoomOut(in: viewport)

        #expect(zoom.scale == ZoomState.minScale)
        #expect(zoom.offset == .zero)
    }

    @Test("The point under the finger stays under the finger while zooming")
    func zoomIsAnchoredOnTheTappedPoint() {
        let anchor = CGPoint(x: 60, y: 120)
        var zoom = ZoomState()

        func contentPoint(_ state: ZoomState) -> CGPoint {
            CGPoint(
                x: (anchor.x - viewport.center.x - state.offset.width) / state.scale,
                y: (anchor.y - viewport.center.y - state.offset.height) / state.scale
            )
        }
        let before = contentPoint(zoom)

        zoom.zoom(to: 2, around: anchor, in: viewport)
        let after = contentPoint(zoom)

        #expect(abs(after.x - before.x) < 0.001)
        #expect(abs(after.y - before.y) < 0.001)
    }

    @Test("Zooming with no anchor keeps the middle of the page in the middle")
    func centreZoomScalesTheOffset() {
        var zoom = ZoomState(scale: 2, offset: CGSize(width: 50, height: 100))

        zoom.zoom(to: 4, in: viewport)

        #expect(zoom.offset == CGSize(width: 100, height: 200))
    }

    @Test("A double tap zooms in, and a second one fits the page again")
    func doubleTapTogglesZoom() {
        var zoom = ZoomState()
        let anchor = CGPoint(x: 200, y: 100)

        zoom.toggleZoom(around: anchor, in: viewport)
        #expect(zoom.scale == ZoomState.doubleTapScale)

        zoom.toggleZoom(around: anchor, in: viewport)
        #expect(zoom.scale == ZoomState.minScale)
        #expect(zoom.offset == .zero)
    }

    @Test("Panning stops at the edges of the page")
    func panningIsClampedToTheEdges() {
        var zoom = ZoomState(scale: 2)

        zoom.pan(from: .zero, by: CGSize(width: 10_000, height: 10_000), in: viewport)
        #expect(zoom.offset == CGSize(width: 150, height: 300))

        zoom.pan(from: .zero, by: CGSize(width: -10_000, height: -10_000), in: viewport)
        #expect(zoom.offset == CGSize(width: -150, height: -300))
    }

    @Test("A fitted page cannot be panned around")
    func panningNeedsZoom() {
        var zoom = ZoomState()

        zoom.pan(from: .zero, by: CGSize(width: 120, height: 90), in: viewport)

        #expect(zoom.offset == .zero)
    }

    @Test("A smaller viewport pulls the page back into view")
    func settlingAfterTheViewportShrinks() {
        var zoom = ZoomState(scale: 2)
        zoom.pan(from: .zero, by: CGSize(width: 150, height: 300), in: viewport)

        let narrow = Viewport(size: CGSize(width: 200, height: 400), contentAspectRatio: 0.5)
        zoom.settle(in: narrow)

        #expect(zoom.offset == CGSize(width: 100, height: 200))
    }

    @Test("An empty viewport has nothing to clamp against")
    func emptyViewportIsHandled() {
        var zoom = ZoomState(scale: 3)

        zoom.pan(from: .zero, by: CGSize(width: 50, height: 50), in: .zero)

        #expect(zoom.offset == .zero)
        #expect(Viewport.zero.fittedContentSize == .zero)
    }

    @Test("Zoom is reported as a percentage")
    func percentageIsRounded() {
        #expect(ZoomState(scale: 2.5).percentage == 250)
        #expect(ZoomState(scale: 1.234).percentage == 123)
    }
}

@Suite("Viewport")
struct ViewportTests {
    @Test("A page taller than the viewport is fitted by height")
    func fitsTallContentByHeight() {
        let viewport = Viewport(size: CGSize(width: 400, height: 400), contentAspectRatio: 0.5)

        #expect(viewport.fittedContentSize == CGSize(width: 200, height: 400))
    }

    @Test("A page wider than the viewport is fitted by width")
    func fitsWideContentByWidth() {
        let viewport = Viewport(size: CGSize(width: 400, height: 400), contentAspectRatio: 2)

        #expect(viewport.fittedContentSize == CGSize(width: 400, height: 200))
    }

    @Test("A fitted page has no room to move")
    func noOffsetAtScaleOne() {
        let viewport = Viewport(size: CGSize(width: 400, height: 400), contentAspectRatio: 0.5)

        #expect(viewport.maximumOffset(atScale: 1) == .zero)
    }

    @Test("Only the axis that overflows can be panned")
    func offsetGrowsOnlyWhereTheContentOverflows() {
        let viewport = Viewport(size: CGSize(width: 400, height: 400), contentAspectRatio: 0.5)

        // At scale 2 the page is 400x800: it fills the width, so only the vertical axis moves.
        #expect(viewport.maximumOffset(atScale: 2) == CGSize(width: 0, height: 200))
    }
}
