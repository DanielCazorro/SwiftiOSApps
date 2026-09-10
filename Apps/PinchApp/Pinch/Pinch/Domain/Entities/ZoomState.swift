//
//  ZoomState.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics

struct ZoomState: Equatable, Sendable {
    static let minScale: CGFloat = 1
    static let maxScale: CGFloat = 5
    static let step: CGFloat = 1
    static let doubleTapScale: CGFloat = 3

    private static let epsilon: CGFloat = 0.001

    private(set) var scale: CGFloat
    private(set) var offset: CGSize

    init(scale: CGFloat = ZoomState.minScale, offset: CGSize = .zero) {
        self.scale = Self.clampScale(scale)
        self.offset = self.scale > Self.minScale ? offset : .zero
    }

    var isZoomedIn: Bool { scale > Self.minScale + Self.epsilon }
    var canZoomIn: Bool { scale < Self.maxScale - Self.epsilon }
    var canZoomOut: Bool { isZoomedIn }

    var percentage: Int { Int((scale * 100).rounded()) }

    mutating func reset() {
        scale = Self.minScale
        offset = .zero
    }

    mutating func zoom(to newScale: CGFloat, around anchor: CGPoint? = nil, in viewport: Viewport) {
        let target = Self.clampScale(newScale)
        guard target != scale else { return }

        let anchor = anchor ?? viewport.center
        let anchored = CGSize(
            width: anchor.x - viewport.center.x - offset.width,
            height: anchor.y - viewport.center.y - offset.height
        )
        let ratio = target / scale

        scale = target
        offset = CGSize(
            width: anchor.x - viewport.center.x - anchored.width * ratio,
            height: anchor.y - viewport.center.y - anchored.height * ratio
        )
        settle(in: viewport)
    }

    mutating func zoomIn(in viewport: Viewport) {
        zoom(to: (scale + Self.step).rounded(.down), in: viewport)
    }

    mutating func zoomOut(in viewport: Viewport) {
        zoom(to: (scale - Self.step).rounded(.up), in: viewport)
    }

    mutating func toggleZoom(around anchor: CGPoint, in viewport: Viewport) {
        if isZoomedIn {
            reset()
        } else {
            zoom(to: Self.doubleTapScale, around: anchor, in: viewport)
        }
    }

    mutating func magnify(base: CGFloat, by magnification: CGFloat, around anchor: CGPoint, in viewport: Viewport) {
        zoom(to: base * magnification, around: anchor, in: viewport)
    }

    mutating func pan(from base: CGSize, by translation: CGSize, in viewport: Viewport) {
        guard isZoomedIn else { return }
        offset = CGSize(width: base.width + translation.width, height: base.height + translation.height)
        settle(in: viewport)
    }

    mutating func settle(in viewport: Viewport) {
        guard isZoomedIn else {
            offset = .zero
            return
        }
        let limit = viewport.maximumOffset(atScale: scale)
        offset = CGSize(
            width: min(max(offset.width, -limit.width), limit.width),
            height: min(max(offset.height, -limit.height), limit.height)
        )
    }

    private static func clampScale(_ value: CGFloat) -> CGFloat {
        guard value.isFinite else { return minScale }
        return min(max(value, minScale), maxScale)
    }
}
