//
//  Viewport.swift
//  Pinch
//
//  Created by Daniel Cazorro on 10/09/2026.
//

import CoreGraphics

struct Viewport: Equatable, Sendable {
    static let zero = Viewport(size: .zero, contentAspectRatio: 1)

    let size: CGSize
    let contentAspectRatio: CGFloat

    var isEmpty: Bool { size.width <= 0 || size.height <= 0 || contentAspectRatio <= 0 }
    var center: CGPoint { CGPoint(x: size.width / 2, y: size.height / 2) }

    var fittedContentSize: CGSize {
        guard !isEmpty else { return .zero }
        return size.width / size.height > contentAspectRatio
            ? CGSize(width: size.height * contentAspectRatio, height: size.height)
            : CGSize(width: size.width, height: size.width / contentAspectRatio)
    }

    func maximumOffset(atScale scale: CGFloat) -> CGSize {
        guard !isEmpty else { return .zero }
        let content = fittedContentSize
        return CGSize(
            width: max(0, (content.width * scale - size.width) / 2),
            height: max(0, (content.height * scale - size.height) / 2)
        )
    }
}
